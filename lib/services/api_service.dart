import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://6a3eaca70443193a1a0c3415.mockapi.io';

  
  Future<http.Response> registerUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    return await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );
  }

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Gagal mengambil data user");
    }
  }

  
  Future<List<dynamic>> getFoods() async {
    final response = await http.get(
      Uri.parse('$baseUrl/foods'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Gagal mengambil data makanan");
    }
  }
}