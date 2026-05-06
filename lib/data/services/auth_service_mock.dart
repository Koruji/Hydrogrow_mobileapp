import 'package:hydrogrow/data/mock/User_mock.dart';

class AuthService {
  static Map<String, dynamic>? login(String email, String password) {
    try {
      return mockUsers.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
      );
    } catch (e) {
      return null;
    }
  }

  static bool register(String login, String email, String password) {
    try {
      final alreadyExists = mockUsers.any(
        (user) => user['email'] == email || user['login'] == login,
      );

      if (alreadyExists) return false;

      mockUsers.add({'login': login, 'email': email, 'password': password});

      return true;
    } catch (e) {
      return false;
    }
  }
}
