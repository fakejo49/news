import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

class UserService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://api.wafe.co.id/api"));
  final storage = const FlutterSecureStorage();

  // REGISTER
  Future<String> register(String name, String email, String password) async {
    final response = await _dio.post('/register', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    return response.data['message'] ?? 'Registered successfully';
  }

  // LOGIN
  Future<String> login(String email, String password) async {
    final response = await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    final token = response.data['token'];
    await storage.write(key: 'token', value: token);

    return token;
  }

  // GET PROFILE
  Future<User> getProfile() async {
    final token = await storage.read(key: 'token');
    final response = await _dio.get('/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return User.fromJson(response.data['data']);
  }

  // UPDATE PASSWORD
  Future<String> updatePassword(String oldPass, String newPass) async {
    final token = await storage.read(key: 'token');
    final response = await _dio.post('/update-password',
        data: {'old_password': oldPass, 'new_password': newPass},
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data['message'] ?? 'Password updated';
  }

  // LOGOUT
  Future<void> logout() async {
    await storage.deleteAll();
  }
}
