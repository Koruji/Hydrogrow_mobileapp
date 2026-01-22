import 'package:flutter/material.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/widgets/divider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      //TODO logique de formation de form - ajouter un models + controller
      debugPrint("Login: ${_loginController.text}");
      debugPrint("Email: ${_emailController.text}");
      debugPrint("Password: ${_passwordController.text}");
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
          SizedBox(height: 20),
          if (!_isLogin)
            TextFormField(
              controller: _loginController,
              decoration: InputDecoration(
                icon: Icon(Icons.login),
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
                  return "Login requis";
                }
                return null;
              },
            ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context).textTheme.labelSmall,
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
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
                return "Email requis";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.password),
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
              if (value == null || value.length < 6) {
                return translate.connexion_error_create_password;
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(
                _isLogin ? translate.login_send : translate.create_account_send,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          SizedBox(height: 20),
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
