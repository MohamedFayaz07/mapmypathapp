import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey =
      'AIzaSyDlRez_wHTiTBKKFWNQSlVQVt0jgI-dfxA'; 

  static const String _url =
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$_apiKey';


  static Future<String> generateResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to get response: ${response.body}');
    }
  }
}
