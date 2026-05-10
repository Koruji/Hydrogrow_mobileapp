import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'HydroGrow'**
  String get app_name;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_title;

  /// No description provided for @login_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password;

  /// No description provided for @login_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get login_forgot_password;

  /// No description provided for @login_no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get login_no_account;

  /// No description provided for @login_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get login_sign_up;

  /// No description provided for @login_send.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login_send;

  /// No description provided for @create_account_title.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get create_account_title;

  /// No description provided for @create_account_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get create_account_username;

  /// No description provided for @create_account_send.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account_send;

  /// No description provided for @create_account_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get create_account_have_account;

  /// No description provided for @create_account_login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get create_account_login;

  /// No description provided for @connexion_error_create_password.
  ///
  /// In en, this message translates to:
  /// **'Your password must be at least 6 characters long.'**
  String get connexion_error_create_password;

  /// No description provided for @connexion_error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get connexion_error_invalid_email;

  /// No description provided for @connexion_error_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get connexion_error_user_not_found;

  /// No description provided for @connexion_error_wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get connexion_error_wrong_password;

  /// No description provided for @connexion_error_generic.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get connexion_error_generic;

  /// No description provided for @connexion_error_email_in_use.
  ///
  /// In en, this message translates to:
  /// **'This email address is already in use.'**
  String get connexion_error_email_in_use;

  /// No description provided for @connexion_error_mandatory.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get connexion_error_mandatory;

  /// No description provided for @dashboard_welcome.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get dashboard_welcome;

  /// No description provided for @dashboard_block_1_title.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard_block_1_title;

  /// No description provided for @dashboard_block_2_title.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get dashboard_block_2_title;

  /// No description provided for @dashboard_block_2_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a post to your favorites in the Community tab to see it here.'**
  String get dashboard_block_2_subtitle;

  /// No description provided for @dashboard_block_4_title.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get dashboard_block_4_title;

  /// No description provided for @dashboard_premium.
  ///
  /// In en, this message translates to:
  /// **'Access our PREMIUM version for a better experience!'**
  String get dashboard_premium;

  /// No description provided for @dashboard_alert_message.
  ///
  /// In en, this message translates to:
  /// **'Dashboard edit mode is enabled!'**
  String get dashboard_alert_message;

  /// No description provided for @menu_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get menu_dashboard;

  /// No description provided for @menu_community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get menu_community;

  /// No description provided for @menu_stock.
  ///
  /// In en, this message translates to:
  /// **'Stock Tracking'**
  String get menu_stock;

  /// No description provided for @menu_parcels.
  ///
  /// In en, this message translates to:
  /// **'Parcel Management'**
  String get menu_parcels;

  /// No description provided for @menu_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get menu_account;

  /// No description provided for @account_page_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get account_page_theme;

  /// No description provided for @account_page_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get account_page_language;

  /// No description provided for @account_page_dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get account_page_dark_mode;

  /// No description provided for @account_page_light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get account_page_light_mode;

  /// No description provided for @account_page_language_french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get account_page_language_french;

  /// No description provided for @account_page_language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get account_page_language_english;

  /// No description provided for @account_page_parameters.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get account_page_parameters;

  /// No description provided for @account_page_subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get account_page_subscription;

  /// No description provided for @account_page_subscription_state.
  ///
  /// In en, this message translates to:
  /// **'Current Status'**
  String get account_page_subscription_state;

  /// No description provided for @account_page_subscription_state_1.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get account_page_subscription_state_1;

  /// No description provided for @account_page_subscription_state_2.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get account_page_subscription_state_2;

  /// No description provided for @account_page_no_subscription.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get account_page_no_subscription;

  /// No description provided for @account_page_actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get account_page_actions;

  /// No description provided for @account_page_rgpd.
  ///
  /// In en, this message translates to:
  /// **'View GDPR Policy'**
  String get account_page_rgpd;

  /// No description provided for @account_page_logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get account_page_logout;

  /// No description provided for @account_page_logout_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get account_page_logout_content;

  /// No description provided for @account_page_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get account_page_delete_account;

  /// No description provided for @account_page_logout_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get account_page_logout_cancel;

  /// No description provided for @account_page_logout_confirm.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get account_page_logout_confirm;

  /// No description provided for @account_page_rgpd_title.
  ///
  /// In en, this message translates to:
  /// **'Our Commitments and Principles'**
  String get account_page_rgpd_title;

  /// No description provided for @account_page_rgpd_data_minimization.
  ///
  /// In en, this message translates to:
  /// **'Data Minimization\nWe apply a strict data minimization policy: we only collect what is strictly necessary for the processing and proper functioning of your crops. No superfluous data is requested.'**
  String get account_page_rgpd_data_minimization;

  /// No description provided for @account_page_rgpd_purpose_limitation.
  ///
  /// In en, this message translates to:
  /// **'Purpose Limitation\nWe clearly define the purpose of data collection for each piece of information. Your data is used solely for managing your account and monitoring your installations, without misuse.'**
  String get account_page_rgpd_purpose_limitation;

  /// No description provided for @account_page_rgpd_retention.
  ///
  /// In en, this message translates to:
  /// **'Data Retention\nWe have implemented automatic purge mechanisms. Your data is only retained for as long as necessary to provide the service and is permanently deleted upon account closure.'**
  String get account_page_rgpd_retention;

  /// No description provided for @account_page_rgpd_security.
  ///
  /// In en, this message translates to:
  /// **'Security\nWe ensure the protection of your information through robust encryption technologies and data anonymization whenever possible, guaranteeing their integrity and confidentiality.'**
  String get account_page_rgpd_security;

  /// No description provided for @account_page_rgpd_transparency.
  ///
  /// In en, this message translates to:
  /// **'Transparency\nWe are committed to documenting data processing in a clear manner. You have full visibility into the use of your personal information through this page and our documentation.'**
  String get account_page_rgpd_transparency;

  /// No description provided for @account_page_rgpd_button.
  ///
  /// In en, this message translates to:
  /// **'View GDPR Policy'**
  String get account_page_rgpd_button;

  /// No description provided for @rgpd_page_title.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy & GDPR'**
  String get rgpd_page_title;

  /// No description provided for @rgpd_page_back_button.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get rgpd_page_back_button;

  /// No description provided for @subscription_page_title.
  ///
  /// In en, this message translates to:
  /// **'License & Subscription Management'**
  String get subscription_page_title;

  /// No description provided for @subscription_page_current_subscription.
  ///
  /// In en, this message translates to:
  /// **'Your Current Subscription'**
  String get subscription_page_current_subscription;

  /// No description provided for @subscription_page_status.
  ///
  /// In en, this message translates to:
  /// **'STATUS: '**
  String get subscription_page_status;

  /// No description provided for @subscription_page_active_status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get subscription_page_active_status;

  /// No description provided for @subscription_page_next_due.
  ///
  /// In en, this message translates to:
  /// **'NEXT DUE DATE: '**
  String get subscription_page_next_due;

  /// No description provided for @subscription_page_not_applicable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get subscription_page_not_applicable;

  /// No description provided for @subscription_page_activate_code.
  ///
  /// In en, this message translates to:
  /// **'Activate a Code'**
  String get subscription_page_activate_code;

  /// No description provided for @subscription_page_activate_code_description.
  ///
  /// In en, this message translates to:
  /// **'Enter your license or subscription key to upgrade your account.'**
  String get subscription_page_activate_code_description;

  /// No description provided for @subscription_page_activate_button.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get subscription_page_activate_button;

  /// No description provided for @subscription_page_premium_title.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get subscription_page_premium_title;

  /// No description provided for @subscription_page_premium_description.
  ///
  /// In en, this message translates to:
  /// **'For individuals & enthusiasts'**
  String get subscription_page_premium_description;

  /// No description provided for @subscription_page_pro_title.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get subscription_page_pro_title;

  /// No description provided for @subscription_page_pro_description.
  ///
  /// In en, this message translates to:
  /// **'For businesses & professional growers'**
  String get subscription_page_pro_description;

  /// No description provided for @subscription_page_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscription_page_monthly;

  /// No description provided for @subscription_page_yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get subscription_page_yearly;

  /// No description provided for @subscription_page_lifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get subscription_page_lifetime;

  /// No description provided for @subscription_page_choose_button.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get subscription_page_choose_button;

  /// No description provided for @subscription_page_feature_unlimited_sensors.
  ///
  /// In en, this message translates to:
  /// **'Unlimited access to sensors'**
  String get subscription_page_feature_unlimited_sensors;

  /// No description provided for @subscription_page_feature_history_30_days.
  ///
  /// In en, this message translates to:
  /// **'Full history (30 days)'**
  String get subscription_page_feature_history_30_days;

  /// No description provided for @subscription_page_feature_priority_support.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get subscription_page_feature_priority_support;

  /// No description provided for @subscription_page_feature_custom_alerts.
  ///
  /// In en, this message translates to:
  /// **'Custom alerts'**
  String get subscription_page_feature_custom_alerts;

  /// No description provided for @subscription_page_feature_multi_installations.
  ///
  /// In en, this message translates to:
  /// **'Multi-installation management'**
  String get subscription_page_feature_multi_installations;

  /// No description provided for @subscription_page_feature_advanced_ai.
  ///
  /// In en, this message translates to:
  /// **'Advanced AI analysis'**
  String get subscription_page_feature_advanced_ai;

  /// No description provided for @subscription_page_feature_data_export.
  ///
  /// In en, this message translates to:
  /// **'Data export (CSV/Excel)'**
  String get subscription_page_feature_data_export;

  /// No description provided for @subscription_page_feature_technical_support_24_7.
  ///
  /// In en, this message translates to:
  /// **'24/7 technical support'**
  String get subscription_page_feature_technical_support_24_7;

  /// No description provided for @subscription_page_offer_free_trial.
  ///
  /// In en, this message translates to:
  /// **'2 months free'**
  String get subscription_page_offer_free_trial;

  /// No description provided for @subscription_page_offer_discount.
  ///
  /// In en, this message translates to:
  /// **'15% OFF'**
  String get subscription_page_offer_discount;

  /// No description provided for @subscription_page_hardware_title.
  ///
  /// In en, this message translates to:
  /// **'Our IoT Hardware Packs'**
  String get subscription_page_hardware_title;

  /// No description provided for @subscription_page_hardware_description.
  ///
  /// In en, this message translates to:
  /// **'Ready-to-use solutions, pre-assembled and calibrated, including 1 year of Cultivateur subscription.'**
  String get subscription_page_hardware_description;

  /// No description provided for @subscription_page_essential_pack.
  ///
  /// In en, this message translates to:
  /// **'Essential Pack'**
  String get subscription_page_essential_pack;

  /// No description provided for @subscription_page_essential_pack_description.
  ///
  /// In en, this message translates to:
  /// **'The survival kit (pH/EC/Temp Monitoring)'**
  String get subscription_page_essential_pack_description;

  /// No description provided for @subscription_page_comfort_pack.
  ///
  /// In en, this message translates to:
  /// **'Comfort Pack'**
  String get subscription_page_comfort_pack;

  /// No description provided for @subscription_page_comfort_pack_description.
  ///
  /// In en, this message translates to:
  /// **'Full autonomy with pH management.'**
  String get subscription_page_comfort_pack_description;

  /// No description provided for @subscription_page_total_ia_pack.
  ///
  /// In en, this message translates to:
  /// **'Total AI Pack'**
  String get subscription_page_total_ia_pack;

  /// No description provided for @subscription_page_total_ia_pack_description.
  ///
  /// In en, this message translates to:
  /// **'High performance and computer vision.'**
  String get subscription_page_total_ia_pack_description;

  /// No description provided for @subscription_page_order_button.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get subscription_page_order_button;

  /// No description provided for @subscription_page_feature_ph_ec_probe.
  ///
  /// In en, this message translates to:
  /// **'Industrial pH & EC Probe'**
  String get subscription_page_feature_ph_ec_probe;

  /// No description provided for @subscription_page_feature_water_temp_sensor.
  ///
  /// In en, this message translates to:
  /// **'Water Temperature Sensor'**
  String get subscription_page_feature_water_temp_sensor;

  /// No description provided for @subscription_page_feature_water_level_sensor.
  ///
  /// In en, this message translates to:
  /// **'Water Level Sensor (Anti-dry)'**
  String get subscription_page_feature_water_level_sensor;

  /// No description provided for @subscription_page_feature_irrigation_control.
  ///
  /// In en, this message translates to:
  /// **'Irrigation Pump Control'**
  String get subscription_page_feature_irrigation_control;

  /// No description provided for @subscription_page_feature_waterproof_case.
  ///
  /// In en, this message translates to:
  /// **'Waterproof IP65 Case'**
  String get subscription_page_feature_waterproof_case;

  /// No description provided for @subscription_page_feature_auto_dosing.
  ///
  /// In en, this message translates to:
  /// **'Automatic Dosing'**
  String get subscription_page_feature_auto_dosing;

  /// No description provided for @subscription_page_feature_air_sensors.
  ///
  /// In en, this message translates to:
  /// **'Air Sensors (Temp/Humidity/Light)'**
  String get subscription_page_feature_air_sensors;

  /// No description provided for @subscription_page_feature_ph_regulation_pumps.
  ///
  /// In en, this message translates to:
  /// **'pH Regulation Pumps'**
  String get subscription_page_feature_ph_regulation_pumps;

  /// No description provided for @subscription_page_feature_auto_nutrient_doser.
  ///
  /// In en, this message translates to:
  /// **'Automatic Nutrient Doser'**
  String get subscription_page_feature_auto_nutrient_doser;

  /// No description provided for @subscription_page_feature_led_relay.
  ///
  /// In en, this message translates to:
  /// **'LED Lighting Relay'**
  String get subscription_page_feature_led_relay;

  /// No description provided for @subscription_page_feature_plug_and_play.
  ///
  /// In en, this message translates to:
  /// **'Plug & Play Installation'**
  String get subscription_page_feature_plug_and_play;

  /// No description provided for @subscription_page_feature_co2_camera.
  ///
  /// In en, this message translates to:
  /// **'CO2 Camera & Flowmeter'**
  String get subscription_page_feature_co2_camera;

  /// No description provided for @subscription_page_feature_ai_camera.
  ///
  /// In en, this message translates to:
  /// **'AI Camera (Time-lapse/Health)'**
  String get subscription_page_feature_ai_camera;

  /// No description provided for @subscription_page_feature_galvanic_isolation.
  ///
  /// In en, this message translates to:
  /// **'Galvanic Isolation Pro'**
  String get subscription_page_feature_galvanic_isolation;

  /// No description provided for @subscription_page_feature_agronomist_subscription.
  ///
  /// In en, this message translates to:
  /// **'Agronomist Subscription (1 year)'**
  String get subscription_page_feature_agronomist_subscription;

  /// No description provided for @subscription_page_feature_three_year_warranty.
  ///
  /// In en, this message translates to:
  /// **'3-Year Warranty'**
  String get subscription_page_feature_three_year_warranty;

  /// No description provided for @common_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get common_edit;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @stock_page_title.
  ///
  /// In en, this message translates to:
  /// **'Stock Tracking'**
  String get stock_page_title;

  /// No description provided for @stock_page_items_label.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get stock_page_items_label;

  /// No description provided for @stock_page_empty.
  ///
  /// In en, this message translates to:
  /// **'No items in stock.'**
  String get stock_page_empty;

  /// No description provided for @stock_page_alert_label.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get stock_page_alert_label;

  /// No description provided for @stock_card_expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get stock_card_expiry;

  /// No description provided for @stock_card_threshold.
  ///
  /// In en, this message translates to:
  /// **'Threshold'**
  String get stock_card_threshold;

  /// No description provided for @stock_card_total_value.
  ///
  /// In en, this message translates to:
  /// **'Total value'**
  String get stock_card_total_value;

  /// No description provided for @stock_card_unit_cost.
  ///
  /// In en, this message translates to:
  /// **'Unit cost'**
  String get stock_card_unit_cost;

  /// No description provided for @stock_status_faible.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get stock_status_faible;

  /// No description provided for @stock_status_moyen.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get stock_status_moyen;

  /// No description provided for @stock_status_optimal.
  ///
  /// In en, this message translates to:
  /// **'Optimal'**
  String get stock_status_optimal;

  /// No description provided for @stock_status_rupture.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get stock_status_rupture;

  /// No description provided for @parcel_page_title.
  ///
  /// In en, this message translates to:
  /// **'Parcel Management'**
  String get parcel_page_title;

  /// No description provided for @parcel_page_count_label.
  ///
  /// In en, this message translates to:
  /// **'parcels'**
  String get parcel_page_count_label;

  /// No description provided for @parcel_page_empty.
  ///
  /// In en, this message translates to:
  /// **'No parcels found.'**
  String get parcel_page_empty;

  /// No description provided for @parcel_page_inactive_label.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get parcel_page_inactive_label;

  /// No description provided for @parcel_status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get parcel_status_active;

  /// No description provided for @parcel_status_inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get parcel_status_inactive;

  /// No description provided for @parcel_status_planned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get parcel_status_planned;

  /// No description provided for @parcel_card_commissioned.
  ///
  /// In en, this message translates to:
  /// **'Commissioned'**
  String get parcel_card_commissioned;

  /// No description provided for @parcel_card_plants.
  ///
  /// In en, this message translates to:
  /// **'Plants'**
  String get parcel_card_plants;

  /// No description provided for @parcel_inactive_section.
  ///
  /// In en, this message translates to:
  /// **'Inactive parcels'**
  String get parcel_inactive_section;

  /// No description provided for @parcel_label_plants.
  ///
  /// In en, this message translates to:
  /// **'plants'**
  String get parcel_label_plants;

  /// No description provided for @parcel_summary_title.
  ///
  /// In en, this message translates to:
  /// **'Parcels'**
  String get parcel_summary_title;

  /// No description provided for @parcel_summary_parcels_label.
  ///
  /// In en, this message translates to:
  /// **'parcels'**
  String get parcel_summary_parcels_label;

  /// No description provided for @parcel_summary_plants_label.
  ///
  /// In en, this message translates to:
  /// **'plants'**
  String get parcel_summary_plants_label;

  /// No description provided for @parcel_summary_inactive_label.
  ///
  /// In en, this message translates to:
  /// **'inactive'**
  String get parcel_summary_inactive_label;

  /// No description provided for @community_page_title.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community_page_title;

  /// No description provided for @community_page_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Share your experiences'**
  String get community_page_subtitle;

  /// No description provided for @community_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get community_search_hint;

  /// No description provided for @community_filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get community_filter_all;

  /// No description provided for @community_reset_filters.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get community_reset_filters;

  /// No description provided for @community_empty.
  ///
  /// In en, this message translates to:
  /// **'No articles found.'**
  String get community_empty;

  /// No description provided for @community_articles_count_label.
  ///
  /// In en, this message translates to:
  /// **'articles'**
  String get community_articles_count_label;

  /// No description provided for @community_stat_articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get community_stat_articles;

  /// No description provided for @community_stat_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get community_stat_categories;

  /// No description provided for @community_stat_mine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get community_stat_mine;

  /// No description provided for @community_summary_title.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community_summary_title;

  /// No description provided for @community_summary_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Latest posts'**
  String get community_summary_subtitle;

  /// No description provided for @community_summary_new_label.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get community_summary_new_label;

  /// No description provided for @community_summary_empty.
  ///
  /// In en, this message translates to:
  /// **'No recent posts.'**
  String get community_summary_empty;

  /// No description provided for @article_read_min.
  ///
  /// In en, this message translates to:
  /// **'min read'**
  String get article_read_min;

  /// No description provided for @article_my_article.
  ///
  /// In en, this message translates to:
  /// **'My article'**
  String get article_my_article;

  /// No description provided for @article_action_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get article_action_edit;

  /// No description provided for @article_action_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get article_action_delete;

  /// No description provided for @article_detail_read_label.
  ///
  /// In en, this message translates to:
  /// **'min read'**
  String get article_detail_read_label;

  /// No description provided for @article_detail_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get article_detail_tags;

  /// No description provided for @article_detail_you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get article_detail_you;

  /// No description provided for @article_form_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get article_form_back;

  /// No description provided for @article_form_title_label.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get article_form_title_label;

  /// No description provided for @article_form_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Article title'**
  String get article_form_title_hint;

  /// No description provided for @article_form_title_required.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get article_form_title_required;

  /// No description provided for @article_form_content_label.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get article_form_content_label;

  /// No description provided for @article_form_content_hint.
  ///
  /// In en, this message translates to:
  /// **'Article content'**
  String get article_form_content_hint;

  /// No description provided for @article_form_content_min.
  ///
  /// In en, this message translates to:
  /// **'Content must be at least 10 characters'**
  String get article_form_content_min;

  /// No description provided for @article_form_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get article_form_category;

  /// No description provided for @article_form_image_label.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get article_form_image_label;

  /// No description provided for @article_form_image_hint.
  ///
  /// In en, this message translates to:
  /// **'Image URL'**
  String get article_form_image_hint;

  /// No description provided for @article_form_tags_label.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get article_form_tags_label;

  /// No description provided for @article_form_tags_hint.
  ///
  /// In en, this message translates to:
  /// **'tag1, tag2, tag3'**
  String get article_form_tags_hint;

  /// No description provided for @article_form_publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get article_form_publish;

  /// No description provided for @article_form_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get article_form_save;

  /// No description provided for @sidebar_menu_label.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get sidebar_menu_label;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
