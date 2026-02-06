// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'HydroGrow';

  @override
  String get login => 'Login';

  @override
  String get login_title => 'Login';

  @override
  String get login_email => 'Email';

  @override
  String get login_password => 'Password';

  @override
  String get login_forgot_password => 'Forgot your password?';

  @override
  String get login_no_account => 'Don\'t have an account? ';

  @override
  String get login_sign_up => 'Sign up';

  @override
  String get login_send => 'Log in';

  @override
  String get create_account_title => 'Create an account';

  @override
  String get create_account_username => 'Username';

  @override
  String get create_account_send => 'Create account';

  @override
  String get create_account_have_account => 'Already have an account? ';

  @override
  String get create_account_login => 'Log in';

  @override
  String get connexion_error_create_password =>
      'Your password must be at least 6 characters long.';

  @override
  String get connexion_error_invalid_email => 'Invalid email address.';

  @override
  String get connexion_error_user_not_found => 'User not found.';

  @override
  String get connexion_error_wrong_password => 'Incorrect password.';

  @override
  String get connexion_error_generic => 'An error occurred. Please try again.';

  @override
  String get connexion_error_email_in_use =>
      'This email address is already in use.';

  @override
  String get connexion_error_mandatory => 'This field is required.';

  @override
  String get dashboard_welcome => 'Hello';

  @override
  String get dashboard_block_1_title => 'Dashboard';

  @override
  String get dashboard_block_2_title => 'Community';

  @override
  String get dashboard_block_2_subtitle =>
      'Add a post to your favorites in the Community tab to see it here.';

  @override
  String get dashboard_block_3_title => 'Expenses';

  @override
  String get dashboard_block_3_admin_title => 'Finances';

  @override
  String get dashboard_block_4_title => 'Community';

  @override
  String get dashboard_premium =>
      'Access our PREMIUM version for a better experience!';

  @override
  String get menu_dashboard => 'Dashboard';

  @override
  String get menu_community => 'Community';

  @override
  String get menu_expenses => 'Expense Tracking';

  @override
  String get menu_stock => 'Stock Tracking';

  @override
  String get menu_parcels => 'Parcel Management';

  @override
  String get menu_account => 'My Account';
}
