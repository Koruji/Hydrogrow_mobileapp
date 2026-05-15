import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/token_service.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;

  Future<Map<String, dynamic>> login(
      String identifier, String password) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'identifier': identifier, 'password': password},
    );
    final token = response.data['access_token'] as String;
    await TokenService.saveToken(token);
    return getMe();
  }

  Future<bool> register(
      String username, String email, String password) async {
    final response = await _dio.post(
      '/auth/register',
      data: {'username': username, 'email': email, 'password': password},
    );
    return response.statusCode == 201;
  }

  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } finally {
      await TokenService.deleteToken();
    }
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _dio.get('/auth/me');
    final data = response.data as Map;
    final user = data.containsKey('user') ? data['user'] : data;
    return Map<String, dynamic>.from(user as Map);
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post('/auth/forgot-password', data: {'email': email});
  }

  Future<bool> isLoggedIn() => TokenService.hasToken();
}
