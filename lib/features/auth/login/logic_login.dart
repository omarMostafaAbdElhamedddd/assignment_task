
import 'dart:convert';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/features/auth/login/storeAndRetriveToken.dart';
import 'package:assignment_task/features/home/home_view.dart';
import 'package:assignment_task/utilities/consts.dart';
import 'package:assignment_task/utilities/customerSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:http/http.dart' as http;

class SignInCubit extends Cubit<AuthStatee> {

  SignInCubit() : super(AuthStatee(AuthStatus.initial));

  Future<void> login(String userName, String password, var scaffoldMessengerState, BuildContext context) async {
    emit(AuthStatee(AuthStatus.loading));
    print(userName);
    print(password);
    final url = '${baseUrl}/auth/login';
    final Map<String, String> data = {
      "mobile": userName,
      "password": password
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> body = json.decode(response.body);
        StoreAndRetriveToken.storetokenInLocal(body);
        emit(AuthStatee(AuthStatus.success));
        Navigator.push(context,  PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeView(),
        ));
      } else if (response.statusCode == 400) {
        emit(AuthStatee(AuthStatus.failure));
       MySanckBar.snackBar('Email not exists or wrong password',scaffoldMessengerState);
      }else if(response.statusCode==302){
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Conneted without internet,try again', scaffoldMessengerState);
      } else {
        print(response.body);
        print(response.statusCode);
        emit(AuthStatee(AuthStatus.failure));
         MySanckBar.snackBar('Something went wrong', scaffoldMessengerState);
      }
    } on Exception catch (e) {
      emit(AuthStatee(AuthStatus.failure));
      MySanckBar.snackBar('Something went wrong,ensure internet connection', scaffoldMessengerState);
    }
  }

}
