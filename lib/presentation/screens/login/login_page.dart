import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.menu, AppColors.icon],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image(
                      image: AssetImage('assets/images/hydrogrow_logo.png'),
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      translate.app_name,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: screenHeight * 0.25,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(100),
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/login_picture.png',
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.20,
                      left: 20,
                      right: 20,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFDDFEF0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                translate.create_account_title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 20),
                              LoginForm(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
