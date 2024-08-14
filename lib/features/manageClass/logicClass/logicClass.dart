
import 'dart:convert';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/features/auth/login/storeAndRetriveToken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../utilities/consts.dart';
import '../../../utilities/customerSnackBar.dart';
import '../../get_classes_and_search/manager/logic.dart';







class AddClassVubit extends Cubit<AuthStatee>{

  AddClassVubit() : super(AuthStatee(AuthStatus.initial));


  addClass(String arName ,String enName ,var scaffoldMessengerState, BuildContext context ,String id  , String schoolId) async {
    emit(AuthStatee(AuthStatus.loading));
    final token = await StoreAndRetriveToken.getAuthToken();
    final url = '${baseUrl}/school/classes';

    final Map<String, String> data = {
      "name_ar": arName,
      "name_en": enName,
      "school_id": schoolId,
      "grade_id": id,

    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        final Map<String, dynamic> body = json.decode(response.body);

        emit(AuthStatee(AuthStatus.success));
        BlocProvider.of<GetClassesCubit>(context)..getClasses();
        MySanckBar.snackBar('Class is added successfully',scaffoldMessengerState);
      } else if (response.statusCode == 422) {
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Arabic name and Engish name must be unique',scaffoldMessengerState);
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
  updateClass (String arName ,String enName ,var scaffoldMessengerState,String id , String schoolId , String grade_id , BuildContext context) async {
    emit(AuthStatee(AuthStatus.loading));
    final token = await StoreAndRetriveToken.getAuthToken();
    final url = '${baseUrl}/school/classes/${id}';

    final Map<String, dynamic> data = {
      "name_ar": arName,
      "name_en": enName,
      "grade_id": grade_id,
      "school_id": schoolId

    };
print(data);
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      print(data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        final Map<String, dynamic> body = json.decode(response.body);

        emit(AuthStatee(AuthStatus.success));
        BlocProvider.of<GetClassesCubit>(context)..getClasses();
        MySanckBar.snackBar('Class is updated successfully',scaffoldMessengerState);
      } else if (response.statusCode == 422) {
        print(response.body);
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Arabic name and Engish name must be unique',scaffoldMessengerState);
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

  deleteClass(var scaffoldMessengerState, String id, BuildContext context) async {
    emit(AuthStatee(AuthStatus.loading));
    final token = await StoreAndRetriveToken.getAuthToken();
    final url = '${baseUrl}/school/classes/$id';
    print(url);

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 204 || response.statusCode == 200) {

        emit(AuthStatee(AuthStatus.success));
        BlocProvider.of<GetClassesCubit>(context)..getClasses();
        MySanckBar.snackBar('Class deleted successfully', scaffoldMessengerState);
      } else if (response.statusCode == 422) {

        print(response.body);
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Arabic and English names must be unique', scaffoldMessengerState);
      } else if (response.statusCode == 404) {

        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Class not found', scaffoldMessengerState);
      } else if (response.statusCode == 403) {
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Permission denied', scaffoldMessengerState);
      } else {
        // Handle other unexpected errors
        print(response.body);
        print(response.statusCode);
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Something went wrong', scaffoldMessengerState);
      }
    } catch (e) {

      emit(AuthStatee(AuthStatus.failure));
      MySanckBar.snackBar('Something went wrong, ensure internet connection', scaffoldMessengerState);
    }
  }

}

