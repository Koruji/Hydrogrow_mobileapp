import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;
  bool get isLoggedIn => _user != null;

  String get login => _user?['login'] ?? '';
  String get email => _user?['email'] ?? '';

  void setUser(Map<String, dynamic> user) {
    _user = user;
    print(user);
    notifyListeners();
  }

  void logout() {
    _user = null;
    print(user);
    notifyListeners();
  }
}
