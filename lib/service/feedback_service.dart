import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mo_opendata_v2/model/feedback_model.dart';

class FeedbackService {
  static String baseUrl =
      'https://script.google.com/macros/s/AKfycbxfpwOBNj60jWjmTSggfSJrplmbD7r5myBl8ZjMaqyZhjHxM_BtEv6k4BPNoeEqJrzHEw/exec';

  Future<List<FeedbackModel>> getFeedbackList({
    required int limit,
    required int page,
  }) async {
    try {
      var url = Uri.parse('$baseUrl?limit=$limit&page=$page');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var result = convert.jsonDecode(response.body);

        var data = result['data'] as List;

        final feedbackList =
            data.map((json) => FeedbackModel.fromJson(json)).toList();

        if (feedbackList.isEmpty) {
          throw Exception();
        }

        return feedbackList;
      } else {
        throw Exception('Unable to fetch data');
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateStatus({
    required int no,
    required String notes,
  }) async {
    try {
      var url = Uri.parse(baseUrl);

      Map<String, dynamic> result = {};
      await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(
          <String, dynamic>{
            'no': no,
            'notes': notes,
          },
        ),
      )
          .then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            result['ok'] = convert.jsonDecode(response.body)['ok'];
            result['message'] = convert.jsonDecode(response.body)['message'];
          });
        } else {
          result['ok'] = convert.jsonDecode(response.body)['ok'];
          result['message'] = convert.jsonDecode(response.body)['message'];
        }
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postReply({
    required String sheetName,
    required int no,
    required String notes,
    required String picMO,
  }) async {
    try {
      Map<String, dynamic> result = {};
      await http
          .post(Uri.parse(baseUrl),
              body: convert.jsonEncode(<String, dynamic>{
                'sheet_name': sheetName,
                'no': no,
                'notes': notes,
                'pic_mo': picMO,
              }))
          .then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            result['ok'] = convert.jsonDecode(response.body)['ok'];
            result['message'] = convert.jsonDecode(response.body)['message'];
          });
        } else {
          result['ok'] = convert.jsonDecode(response.body)['ok'];
          result['message'] = convert.jsonDecode(response.body)['message'];
        }
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
