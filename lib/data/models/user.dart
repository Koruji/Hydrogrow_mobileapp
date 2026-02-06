class User {
  final String? id;
  final String email;
  final String username;
  final String password;
  final String? accountStatus;
  final String? theme;
  final String? language;
  final String? subscription;
  final String? role;
  // final List<int> installations_id;

  User({
    this.id,
    required this.email,
    required this.username,
    required this.password,
    this.accountStatus,
    this.theme,
    this.language = 'fr',
    this.subscription,
    this.role,
    // required this.installations_id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      accountStatus: json['account_status'],
      theme: json['theme'],
      language: json['language'],
      subscription: json['subscription'],
      role: json['role'],
      password: json['password'],
      // installations_id: List<int>.from(json['installations_id'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'account_status': accountStatus,
      'theme': theme,
      'language': language,
      'subscription': subscription,
      'role': role,
      'password': password,
      // 'installations_id': installations_id,
    };
  }
}
