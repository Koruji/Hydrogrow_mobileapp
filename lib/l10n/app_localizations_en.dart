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
  String get dashboard_alert_message => 'Dashboard edit mode is enabled!';

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

  @override
  String get account_page_theme => 'Theme';

  @override
  String get account_page_language => 'Language';

  @override
  String get account_page_dark_mode => 'Dark Mode';

  @override
  String get account_page_light_mode => 'Light Mode';

  @override
  String get account_page_language_french => 'French';

  @override
  String get account_page_language_english => 'English';

  @override
  String get account_page_parameters => 'Settings';

  @override
  String get account_page_subscription => 'Subscription';

  @override
  String get account_page_subscription_state => 'Current Status';

  @override
  String get account_page_subscription_state_1 => 'Free';

  @override
  String get account_page_subscription_state_2 => 'Premium';

  @override
  String get account_page_no_subscription => 'Go Premium';

  @override
  String get account_page_actions => 'Actions';

  @override
  String get account_page_rgpd => 'View GDPR Policy';

  @override
  String get account_page_logout => 'Log Out';

  @override
  String get account_page_logout_content => 'Are you sure you want to log out?';

  @override
  String get account_page_delete_account => 'Delete My Account';

  @override
  String get account_page_logout_cancel => 'Cancel';

  @override
  String get account_page_logout_confirm => 'Log Out';

  @override
  String get account_page_rgpd_title => 'Our Commitments and Principles';

  @override
  String get account_page_rgpd_data_minimization =>
      'Data Minimization\nWe apply a strict data minimization policy: we only collect what is strictly necessary for the processing and proper functioning of your crops. No superfluous data is requested.';

  @override
  String get account_page_rgpd_purpose_limitation =>
      'Purpose Limitation\nWe clearly define the purpose of data collection for each piece of information. Your data is used solely for managing your account and monitoring your installations, without misuse.';

  @override
  String get account_page_rgpd_retention =>
      'Data Retention\nWe have implemented automatic purge mechanisms. Your data is only retained for as long as necessary to provide the service and is permanently deleted upon account closure.';

  @override
  String get account_page_rgpd_security =>
      'Security\nWe ensure the protection of your information through robust encryption technologies and data anonymization whenever possible, guaranteeing their integrity and confidentiality.';

  @override
  String get account_page_rgpd_transparency =>
      'Transparency\nWe are committed to documenting data processing in a clear manner. You have full visibility into the use of your personal information through this page and our documentation.';

  @override
  String get account_page_rgpd_button => 'View GDPR Policy';

  @override
  String get rgpd_page_title => 'Privacy Policy and GDPR';

  @override
  String get rgpd_page_back_button => 'Back';
}
