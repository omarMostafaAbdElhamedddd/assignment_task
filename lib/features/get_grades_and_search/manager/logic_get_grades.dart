import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../utilities/consts.dart';
import '../../auth/login/storeAndRetriveToken.dart';
import 'grade_model.dart';
import 'states.dart';


class GetGradeubit extends Cubit<GetGradesStates> {
  GetGradeubit() : super(Init());

  Future<void> getGrade() async {
    emit(Loading());
    final url = '${baseUrl}/school/grades';
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
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Grade> grades =
            jsonResponse.map((json) => Grade.fromJson(json)).toList();

        emit(Success(grades));
        print(grades);
      } else {
        // Handle errors
        print(response.body);
        emit(Failure());
        print('Failed to load grades: ${response.statusCode}');
        print(response.body);
      }
    } on Exception catch (e) {
      emit(Failure());
      print('fnsjmznbfjkdghfnjb');
    }
  }
}
