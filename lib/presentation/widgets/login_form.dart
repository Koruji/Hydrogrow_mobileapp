import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/widgets/divider.dart';
import 'package:hydrogrow/presentation/widgets/forgot_password_sheet.dart';
import 'package:hydrogrow/presentation/controllers/auth_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.isLogin,
    required this.onToggle,
  });

  final bool isLogin;
  final VoidCallback onToggle;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _loginFocusNode = FocusNode();

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final login = _loginController.text.trim();

    if (widget.isLogin) {
      final result = AuthController.login(
        context: context,
        email: email,
        password: password,
      );
      if (!mounted) return;
      if (result['success']) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        setState(() => _errorMessage = result['error']);
      }
    } else {
      final result = AuthController.register(
        login: login,
        email: email,
        password: password,
      );
      if (!mounted) return;
      if (result['success']) {
        final loginResult = AuthController.login(
          context: context,
          email: email,
          password: password,
        );
        if (!mounted) return;
        if (loginResult['success']) {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      } else {
        setState(() => _errorMessage = result['error']);
      }
    }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final colors = context.colors;

    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.menu, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.warning),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.warning, width: 2),
      ),
      filled: true,
      fillColor: colors.surface,
      labelStyle: TextStyle(color: colors.textSecondary),
      iconColor: colors.icon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Titre du mode
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              widget.isLogin
                  ? translate.login_title
                  : translate.create_account_title,
              key: ValueKey(widget.isLogin),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Champ username (inscription seulement)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: !widget.isLogin
                ? Column(
                    children: [
                      TextFormField(
                        focusNode: _loginFocusNode,
                        controller: _loginController,
                        style: TextStyle(color: colors.textPrimary),
                        decoration: inputDecoration.copyWith(
                          prefixIcon: Icon(Icons.person_outline_rounded, color: colors.icon),
                          labelText: translate.create_account_username,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return translate.connexion_error_mandatory;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          // Champ email
          TextFormField(
            focusNode: _emailFocusNode,
            controller: _emailController,
            style: TextStyle(color: colors.textPrimary),
            decoration: inputDecoration.copyWith(
              prefixIcon: Icon(Icons.email_outlined, color: colors.icon),
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
          const SizedBox(height: 14),
          // Champ mot de passe
          TextFormField(
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            style: TextStyle(color: colors.textPrimary),
            decoration: inputDecoration.copyWith(
              prefixIcon: Icon(Icons.lock_outline_rounded, color: colors.icon),
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
          // Lien mot de passe oublié
          if (widget.isLogin)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => showForgotPasswordSheet(context),
                style: TextButton.styleFrom(
                  foregroundColor: colors.textSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  translate.forgot_password_link,
                  style: TextStyle(fontSize: 12, color: colors.textSecondary),
                ),
              ),
            ),
          const SizedBox(height: 8),
          // Message d'erreur
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                _errorMessage!,
                style: TextStyle(color: colors.warning, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          // Bouton principal
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.menu,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      widget.isLogin
                          ? translate.login_send
                          : translate.create_account_send,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 24),
          // Toggle login / register
          DividerWithText(
            text: widget.isLogin
                ? translate.login_no_account
                : translate.create_account_have_account,
          ),
          Center(
            child: TextButton(
              onPressed: widget.onToggle,
              child: Text(
                widget.isLogin
                    ? translate.login_sign_up
                    : translate.create_account_login,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.menu,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
