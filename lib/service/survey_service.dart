import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mo_opendata_v2/model/response_model.dart';
import 'package:mo_opendata_v2/model/survey_model.dart';

class SurveyService {
  static String baseUrl =
      'https://script.google.com/macros/s/AKfycbziCWIwssmotzd_DsfPzgNtQxpPfePVGodRqVvS8pVmFszJklrLiFo-UFlMdL7cIyoLzQ/exec';

  Future<List<SurveyModel>> getParticipants() async {
    var url = Uri.parse(baseUrl);

    var response = await http.get(url);

    final result = convert.jsonDecode(response.body);

    final data = result['data'] as List;

    final participants =
        data.map((json) => SurveyModel.fromJson(json)).toList();

    return participants;
  }

  Future<bool> postNotes({required int no, required String notes}) async {
    bool result = false;
    await http
        .post(Uri.parse(baseUrl),
            body: convert.jsonEncode(<String, dynamic>{
              'no': no,
              'notes': notes,
            }))
        .then((response) async {
      if (response.statusCode == 302) {
        var url = response.headers['location'];
        await http.get(Uri.parse(url!)).then((response) {
          result = convert.jsonDecode(response.body)['ok'];
        });
      } else {
        result = convert.jsonDecode(response.body)['ok'];
      }
    });
    return result;
  }
}
