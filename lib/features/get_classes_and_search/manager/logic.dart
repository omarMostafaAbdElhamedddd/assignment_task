import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:assignment_task/features/get_classes_and_search/manager/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/consts.dart';
import '../../auth/login/storeAndRetriveToken.dart';
import '../classModel.dart';

class GetClassesCubit extends Cubit<GetClassesStates> {
  GetClassesCubit() : super(Init());

  Future<void> getClasses() async {
    emit(LoadingClass());
    final url = '${baseUrl}/school/classes';
    final token = await StoreAndRetriveToken.getAuthToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.statusCode);

        List<dynamic> jsonResponse = json.decode(response.body);

        print(jsonResponse);

        List<dynamic> classes =
            jsonResponse.map((json) => Class.fromJson(json)).toList();

        emit(SuccessClass(classes));
        // print(grades);
      } else {
        // Handle errors
        print(response.body);
        emit(FailureClass());
        print('Failed to load grades: ${response.statusCode}');
        print(response.body);
      }
    } on Exception catch (e) {
      emit(FailureClass());
      print('fnsjmznbfjkdghfnjb');
    }
  }
}
