import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mo_opendata_v2/model/clickup_model.dart';

class ClickUpService {
  static String baseUrl = 'https://api.clickup.com/api/v2';

  Future<ClickUpModel> getClickUpSubtask() async {
    try {
      var url = Uri.parse('$baseUrl/task/2cx473f?include_subtasks=true');

      var response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'pk_5983695_F2Y8I4H2H2461GEJFR4318QWU42ZRT7P',
        },
      );

      if (response.statusCode == 200) {
        var result = convert.jsonDecode(response.body);

        final ClickUpModel task = ClickUpModel.fromJson(result);

        return task;
      } else {
        throw Exception('Unable to fetch data');
      }
    } catch (err) {
      rethrow;
    }
  }
}
