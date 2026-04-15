import 'package:flutter/material.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/widgets/divider.dart';
import 'package:hydrogrow/data/mock/user_mock.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();

  // FocusNodes pour chaque champ
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _loginFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Écouteurs si nécessaire
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _loginFocusNode.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    if (!mounted) return;
    setState(() {
      _isLogin = !_isLogin;
      _errorMessage = null;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simule un délai réseau
    await Future.delayed(const Duration(milliseconds: 200));

    if (!mounted) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final user = mockUsers.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = "Email ou mot de passe incorrect";
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                _isLogin
                    ? translate.login_title
                    : translate.create_account_title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!_isLogin)
            TextFormField(
              focusNode: _loginFocusNode,
              controller: _loginController,
              decoration: InputDecoration(
                icon: const Icon(Icons.login),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: translate.login,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translate.connexion_error_mandatory;
                }
                return null;
              },
            ),
          if (!_isLogin) const SizedBox(height: 16),
          TextFormField(
            focusNode: _emailFocusNode,
            style: Theme.of(context).textTheme.labelSmall,
            controller: _emailController,
            decoration: InputDecoration(
              icon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.white,
              labelText: translate.login_email,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translate.connexion_error_mandatory;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            decoration: InputDecoration(
              icon: const Icon(Icons.password),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              helperText: translate.login_forgot_password,
              filled: true,
              fillColor: Colors.white,
              labelText: translate.login_password,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translate.connexion_error_mandatory;
              } else if (value.length < 6) {
                return translate.connexion_error_create_password;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      _isLogin
                          ? translate.login_send
                          : translate.create_account_send,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _toggleAuthMode,
            child: DividerWithText(
              text: _isLogin
                  ? translate.login_no_account
                  : translate.create_account_have_account,
            ),
          ),
        ],
      ),
    );
  }
}
