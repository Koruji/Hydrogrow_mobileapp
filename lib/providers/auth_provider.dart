import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;
  bool get isLoggedIn => _user != null;

  String get username => _user?['username'] ?? _user?['login'] ?? '';
  String get email => _user?['email'] ?? '';
  String get subscription {
    final sub = _user?['subscription'];
    if (sub is Map) return sub['type'] as String? ?? 'freemium';
    return sub as String? ?? 'freemium';
  }
  String get language => _user?['language'] ?? 'fr';
  String get avatarShape => _user?['avatar_shape'] ?? 'circle';
  String get avatarUrl =>
      _user?['avatar_url'] ?? 'assets/images/login_picture.png';
  String get theme => _user?['theme'] ?? 'light';

  void setUser(Map<String, dynamic> user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
