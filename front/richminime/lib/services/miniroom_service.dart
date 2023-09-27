import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';

class MiniroomService {
  static const String baseUrl = Api.BASE_URL;

  Future<String> requestFeedback() async {
    final url = Uri.parse('$baseUrl/feedback');

    final response = await http.get(url, headers: {
      //  "Authorization": "Bearer $accessToken",
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String feedback = responseData['content'];
      return feedback;
    }
    throw Error();
  }
}
