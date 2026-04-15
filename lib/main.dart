import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/core/theme/themes.dart';
import 'package:hydrogrow/presentation/screens/account/account_page.dart';
import 'package:hydrogrow/presentation/screens/dashboard/dashboard_page.dart';
import 'package:hydrogrow/presentation/screens/login/login_page.dart';
import 'package:hydrogrow/presentation/screens/stock/stock_page.dart';
// import 'package:hydrogrow/presentation/screens/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('fr'),
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'HydroGrow',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: LoginPage(),
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/login': (context) => LoginPage(),
        '/stock': (context) => StockPage(),
        '/expenses': (context) =>
            Scaffold(body: Center(child: Text('Expenses Page'))),
        '/community': (context) =>
            Scaffold(body: Center(child: Text('Community Page'))),
        '/parcels': (context) =>
            Scaffold(body: Center(child: Text('Parcels Page'))),
        '/account': (context) => AccountPage(),
      },
    );
  }
}
