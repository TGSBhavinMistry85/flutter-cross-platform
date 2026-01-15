import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  ApiService._privateConstructor();
  static final ApiService instance = ApiService._privateConstructor();

  // Load base URL from env
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? "";

  Map<String, String> getHeaders({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$endpoint"),
      headers: headers ?? getHeaders(),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: headers ?? getHeaders(),
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      throw Exception(
          "Error ${response.statusCode}: ${response.reasonPhrase}");
    }
  }
}