// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'Hydrogrow';

  @override
  String get login_title => 'Connexion';

  @override
  String get login_email => 'Mail';

  @override
  String get login_password => 'Mot de passe';

  @override
  String get login_forgot_password => 'Mot de passe oublié ?';

  @override
  String get login_no_account => 'Pas de compte ? ';

  @override
  String get login_sign_up => 'S\'inscrire';

  @override
  String get login_send => 'Se connecter';

  @override
  String get create_account_title => 'Créer un compte';

  @override
  String get create_account_username => 'Nom d\'utilisateur';

  @override
  String get create_account_send => 'Créer le compte';

  @override
  String get create_account_have_account => 'Déjà un compte ? ';

  @override
  String get create_account_login => 'Se connecter';

  @override
  String get dashboard_welcome => 'Bonjour';

  @override
  String get dashboard_block_1_title => 'Dashboard';

  @override
  String get dashboard_block_2_title => 'Communauté';

  @override
  String get dashboard_block_2_subtitle =>
      'Ajoutez un post en favori dans l\'onglet Communauté pour le faire apparaître ici.';

  @override
  String get dashboard_block_3_title => 'Dépenses';

  @override
  String get dashboard_block_3_admin_title => 'Finances';

  @override
  String get dashboard_block_4_title => 'Communauté';

  @override
  String get dashboard_premium =>
      'Accédez à notre version PREMIUM pour une meilleure expérience !';

  @override
  String get menu_dashboard => 'Tableau de bord';

  @override
  String get menu_community => 'Communauté';

  @override
  String get menu_expenses => 'Suivi des dépenses';

  @override
  String get menu_stock => 'Suivi des stocks';

  @override
  String get menu_parcels => 'Gestion des parcelles';

  @override
  String get menu_account => 'Mon compte';
}
