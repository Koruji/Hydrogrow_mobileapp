import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/core/navigation/app_page_route.dart';
import 'package:hydrogrow/core/theme/themes.dart';
import 'package:hydrogrow/presentation/screens/account/account_page.dart';
import 'package:hydrogrow/presentation/screens/account/subscription_page.dart';
import 'package:hydrogrow/presentation/screens/dashboard/dashboard_page.dart';
import 'package:hydrogrow/presentation/screens/login/login_page.dart';
import 'package:hydrogrow/presentation/screens/account/rgpd_page.dart';
import 'package:hydrogrow/presentation/screens/community/community_page.dart';
import 'package:hydrogrow/presentation/screens/parcels/parcels_page.dart';
import 'package:hydrogrow/presentation/screens/stock/stock_page.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:hydrogrow/providers/theme_provider.dart';
import 'package:hydrogrow/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'HydroGrow',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.mode,
      home: LoginPage(),
      onGenerateRoute: (settings) {
        final routes = <String, Widget>{
          '/dashboard': DashboardPage(),
          '/login': LoginPage(),
          '/stock': StockPage(),
          '/community': const CommunityPage(),
          '/parcels': ParcelsPage(),
          '/account': AccountPage(),
          '/account/rgpd': RGPDPage(),
          '/account/subscription': SubscriptionPage(),
        };
        final page = routes[settings.name];
        if (page != null) {
          return AppPageRoute(page: page, settings: settings);
        }
        return null;
      },
    );
  }
}
