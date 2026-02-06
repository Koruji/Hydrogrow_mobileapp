import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../models/user.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;

  Future<bool> register(String login, String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'login': login,
          'email': email,
          'password': password,
        },
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Erreur ${e.response!.statusCode}: ${e.response!.data}');
      } else {
        throw Exception('Erreur de connexion');
      }
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Erreur ${e.response!.statusCode}: ${e.response!.data}');
      } else {
        throw Exception('Erreur de connexion');
      }
    }
  }
}