import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;
  bool get isLoggedIn => _user != null;

  String get login => _user?['login'] ?? '';
  String get email => _user?['email'] ?? '';
  String get subscription => _user?['subscription'] ?? 'free';
  String get language => _user?['language'] ?? 'fr';
  String get avatarShape => _user?['avatar_shape'] ?? 'circle';
  String get avatarUrl =>
      _user?['avatar_url'] ?? 'assets/images/login_picture.png';
  String get theme => _user?['theme'] ?? 'light';

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
