import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:hydrogrow/data/services/auth_service.dart';

class AuthController {
  static final _service = AuthService();

  static Future<Map<String, dynamic>> login({
    required BuildContext context,
    required String identifier,
    required String password,
  }) async {
    try {
      final user = await _service.login(identifier, password);
      if (context.mounted) {
        Provider.of<AuthProvider>(context, listen: false).setUser(user);
      }
      return {'success': true, 'error': null};
    } catch (e) {
      return {'success': false, 'error': _parseError(e)};
    }
  }

  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _service.register(username, email, password);
      return {'success': true, 'error': null};
    } catch (e) {
      return {'success': false, 'error': _parseError(e)};
    }
  }

  static Future<void> logout(BuildContext context) async {
    await _service.logout();
    if (context.mounted) {
      Provider.of<AuthProvider>(context, listen: false).logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  static Future<bool> tryAutoLogin(BuildContext context) async {
    try {
      final loggedIn = await _service.isLoggedIn();
      if (!loggedIn) return false;
      final user = await _service.getMe();
      if (context.mounted) {
        Provider.of<AuthProvider>(context, listen: false).setUser(user);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static String _parseError(Object e) {
    if (e is DioException) {
      final status = e.response?.statusCode;
      if (status == 401) return 'Email ou mot de passe incorrect';
      if (status == 400) return 'Données invalides';
      if (status == 409) return 'Cet email ou username est déjà utilisé';
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return 'Impossible de joindre le serveur';
      }
    }
    return 'Une erreur est survenue';
  }
}
