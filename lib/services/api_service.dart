import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class ApiService {
  final String baseUrl = "http://api.wafe.co.id/api";

  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {'email': email, 'password': password},
    );
    print(response);
    return response.statusCode == 200;
  }

 Future<bool> registerUser(String name, String email, String password) async {
  final response = await http
    .post(Uri.parse("http://api.wafe.co.id/api/register"), body: {
      'email': email,
      'password': password,
    })
    .timeout(const Duration(seconds: 10));


  return response.statusCode == 200;
}



  Future<User?> getProfile() async {
    final response = await http.get(Uri.parse("$baseUrl/profile"));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    final response = await http.post(
      Uri.parse("$baseUrl/change-password"),
      body: {'old_password': oldPassword, 'new_password': newPassword},
    );
    return response.statusCode == 200;
  }
}
