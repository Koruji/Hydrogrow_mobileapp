import '../../data/services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> register({
    required String login,
    required String email,
    required String password,
  }) async {
    try {
      final success = await _authService.register(login, email, password);
      return {
        'success': success,
        'error': null,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final success = await _authService.login(email, password);
      return {
        'success': success,
        'error': null,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}