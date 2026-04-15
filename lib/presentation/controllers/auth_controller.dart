import 'package:flutter/material.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:hydrogrow/data/services/auth_service_mock.dart';

class AuthController {
  static Map<String, dynamic> login({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    final user = AuthService.login(email, password);

    if (user != null) {
      Provider.of<AuthProvider>(context, listen: false).setUser(user);
      return {'success': true, 'error': null};
    }

    return {'success': false, 'error': 'Email ou mot de passe incorrect'};
  }

  static Map<String, dynamic> register({
    required String login,
    required String email,
    required String password,
  }) {
    final success = AuthService.register(login, email, password);

    if (success) {
      return {'success': true, 'error': null};
    }

    return {'success': false, 'error': 'Cet email ou login est déjà utilisé'};
  }

  static void logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
