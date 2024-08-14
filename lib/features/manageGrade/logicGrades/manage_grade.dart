import 'dart:convert';
import 'package:assignment_task/features/auth/login/states_login.dart';
import 'package:assignment_task/features/auth/login/storeAndRetriveToken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../utilities/consts.dart';
import '../../../utilities/customerSnackBar.dart';
import '../../get_grades_and_search/manager/logic_get_grades.dart';

class ManageGradeCubit extends Cubit<AuthStatee> {
  ManageGradeCubit() : super(AuthStatee(AuthStatus.initial));

  addGrade(String arName, String enName, var scaffoldMessengerState,
      BuildContext context) async {
    emit(AuthStatee(AuthStatus.loading));
    final token = await StoreAndRetriveToken.getAuthToken();
    final url = '${baseUrl}/school/grades';
    String? shoolId = await StoreAndRetriveToken.getschool_id();
    final Map<String, String> data = {
      "name_ar": arName,
      "name_en": enName,
      "school_id": shoolId ?? ''
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
        BlocProvider.of<GetGradeubit>(context)..getGrade();
        MySanckBar.snackBar(
            'Grade is added successfully', scaffoldMessengerState);
      } else if (response.statusCode == 422) {
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Arabic name and Engish name must be unique',
            scaffoldMessengerState);
      } else if (response.statusCode == 302) {
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar(
            'Conneted without internet,try again', scaffoldMessengerState);
      } else {
        print(response.body);
        print(response.statusCode);
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Something went wrong', scaffoldMessengerState);
      }
    } on Exception catch (e) {
      emit(AuthStatee(AuthStatus.failure));
      MySanckBar.snackBar('Something went wrong,ensure internet connection',
          scaffoldMessengerState);
    }
  }

  updateGrade(String arName, String enName, var scaffoldMessengerState,
      String id, String schoolId, BuildContext context) async {
    emit(AuthStatee(AuthStatus.loading));
    final token = await StoreAndRetriveToken.getAuthToken();
    final url = '${baseUrl}/school/grades/${id}';
    print(url);
    // String? shoolId = await StoreAndRetriveToken.getschool_id();
    final Map<String, dynamic> data = {
      "name_ar": arName,
      "name_en": enName,
      "school_id": schoolId
    };

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        final Map<String, dynamic> body = json.decode(response.body);

        emit(AuthStatee(AuthStatus.success));
        BlocProvider.of<GetGradeubit>(context)..getGrade();
        MySanckBar.snackBar(
            'Grade is updated successfully', scaffoldMessengerState);
      } else if (response.statusCode == 422) {
        print(response.body);
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Arabic name and Engish name must be unique',
            scaffoldMessengerState);
      } else if (response.statusCode == 302) {
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar(
            'Conneted without internet,try again', scaffoldMessengerState);
      } else {
        print(response.body);
        print(response.statusCode);
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Something went wrong', scaffoldMessengerState);
      }
    } on Exception catch (e) {
      emit(AuthStatee(AuthStatus.failure));
      MySanckBar.snackBar('Something went wrong,ensure internet connection',
          scaffoldMessengerState);
    }
  }

  deleteGrade(
      var scaffoldMessengerState, String id, BuildContext context) async {
    emit(AuthStatee(AuthStatus.loading));
    final token = await StoreAndRetriveToken.getAuthToken();
    final url = '${baseUrl}/school/grades/${id}';
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

      if (response.statusCode == 204 ||
          response.statusCode == 201 ||
          response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> body = json.decode(response.body);

        emit(AuthStatee(AuthStatus.success));
        BlocProvider.of<GetGradeubit>(context)..getGrade();
        MySanckBar.snackBar(
            'Grade is deleted successfully', scaffoldMessengerState);
      } else if (response.statusCode == 422) {
        print(response.body);
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Arabic name and Engish name must be unique',
            scaffoldMessengerState);
      } else if (response.statusCode == 302) {
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar(
            'Conneted without internet,try again', scaffoldMessengerState);
      } else {
        emit(AuthStatee(AuthStatus.failure));
        MySanckBar.snackBar('Something went wrong', scaffoldMessengerState);
      }
    } on Exception catch (e) {
      emit(AuthStatee(AuthStatus.failure));
      MySanckBar.snackBar('Something went wrong,ensure internet connection',
          scaffoldMessengerState);
    }
  }
}
