// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'HydroGrow';

  @override
  String get login => 'Connexion';

  @override
  String get login_title => 'Connexion';

  @override
  String get login_email => 'Email';

  @override
  String get login_password => 'Mot de passe';

  @override
  String get login_forgot_password => 'Mot de passe oublié ?';

  @override
  String get login_no_account => 'Vous n\'avez pas de compte ? ';

  @override
  String get login_sign_up => 'S\'inscrire';

  @override
  String get login_send => 'Se connecter';

  @override
  String get create_account_title => 'Créer un compte';

  @override
  String get create_account_username => 'Nom d\'utilisateur';

  @override
  String get create_account_send => 'Créer un compte';

  @override
  String get create_account_have_account => 'Vous avez déjà un compte ? ';

  @override
  String get create_account_login => 'Se connecter';

  @override
  String get connexion_error_create_password =>
      'Votre mot de passe doit contenir au moins 6 caractères.';

  @override
  String get connexion_error_invalid_email => 'Adresse email invalide.';

  @override
  String get connexion_error_user_not_found => 'Utilisateur introuvable.';

  @override
  String get connexion_error_wrong_password => 'Mot de passe incorrect.';

  @override
  String get connexion_error_generic =>
      'Une erreur s\'est produite. Veuillez réessayer.';

  @override
  String get connexion_error_email_in_use =>
      'Cette adresse email est déjà utilisée.';

  @override
  String get connexion_error_mandatory => 'Ce champ est obligatoire.';

  @override
  String get dashboard_welcome => 'Bonjour';

  @override
  String get dashboard_block_1_title => 'Tableau de bord';

  @override
  String get dashboard_block_2_title => 'Communauté';

  @override
  String get dashboard_block_2_subtitle =>
      'Ajoutez une publication à vos favoris dans l\'onglet Communauté pour la voir ici.';

  @override
  String get dashboard_block_4_title => 'Communauté';

  @override
  String get dashboard_premium =>
      'Accédez à notre version PREMIUM pour une meilleure expérience !';

  @override
  String get dashboard_alert_message =>
      'Le mode édition du dashboard est activé !';

  @override
  String get menu_dashboard => 'Tableau de bord';

  @override
  String get menu_community => 'Communauté';

  @override
  String get menu_stock => 'Suivi des stocks';

  @override
  String get menu_parcels => 'Gestion des parcelles';

  @override
  String get menu_account => 'Mon compte';

  @override
  String get account_page_theme => 'Thème';

  @override
  String get account_page_language => 'Langue';

  @override
  String get account_page_dark_mode => 'Mode sombre';

  @override
  String get account_page_light_mode => 'Mode clair';

  @override
  String get account_page_language_french => 'Français';

  @override
  String get account_page_language_english => 'Anglais';

  @override
  String get account_page_parameters => 'Paramètres';

  @override
  String get account_page_subscription => 'Abonnement';

  @override
  String get account_page_subscription_state => 'Statut actuel';

  @override
  String get account_page_subscription_state_1 => 'Gratuit';

  @override
  String get account_page_subscription_state_2 => 'Premium';

  @override
  String get account_page_no_subscription => 'Passez Premium';

  @override
  String get account_page_actions => 'Actions';

  @override
  String get account_page_rgpd => 'Consulter la RGPD';

  @override
  String get account_page_logout => 'Se déconnecter';

  @override
  String get account_page_logout_content =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get account_page_delete_account => 'Supprimer mon compte';

  @override
  String get account_page_logout_cancel => 'Annuler';

  @override
  String get account_page_logout_confirm => 'Se déconnecter';

  @override
  String get account_page_rgpd_title => 'Nos Engagements et Principes';

  @override
  String get account_page_rgpd_data_minimization =>
      'Minimisation des données\nNous appliquons une politique stricte de minimisation : nous ne collectons que ce qui est strictement nécessaire pour le traitement et le bon fonctionnement de vos cultures. Aucune donnée superflue n\'est demandée.';

  @override
  String get account_page_rgpd_purpose_limitation =>
      'Limitation des finalités\nNous définissons clairement l\'objectif de la collecte pour chaque donnée. Vos informations servent uniquement à la gestion de votre compte et au monitoring de vos installations, sans détournement d\'usage.';

  @override
  String get account_page_rgpd_retention =>
      'Durée de conservation\nNous avons mis en place des mécanismes de purge automatique. Vos données ne sont conservées que le temps nécessaire à la fourniture du service, et sont supprimées définitivement lors de la clôture de votre compte.';

  @override
  String get account_page_rgpd_security =>
      'Sécurité\nNous assurons la protection de vos informations via des technologies de chiffrement robustes et l\'anonymisation des données lorsque cela est possible, garantissant leur intégrité et confidentialité.';

  @override
  String get account_page_rgpd_transparency =>
      'Transparence\nNous nous engageons à documenter le traitement des données de manière claire. Vous disposez d\'une visibilité totale sur l\'usage de vos informations personnelles via cette page et notre documentation.';

  @override
  String get account_page_rgpd_button => 'Consulter la RGPD';

  @override
  String get rgpd_page_title => 'Politique de Confidentialité et RGPD';

  @override
  String get rgpd_page_back_button => 'Retour';

  @override
  String get subscription_page_title => 'Gestion des Licences & Abonnements';

  @override
  String get subscription_page_current_subscription =>
      'Votre Abonnement Actuel';

  @override
  String get subscription_page_status => 'STATUT: ';

  @override
  String get subscription_page_active_status => 'Actif';

  @override
  String get subscription_page_next_due => 'PROCHAINE ÉCHÉANCE: ';

  @override
  String get subscription_page_not_applicable => 'N/A';

  @override
  String get subscription_page_activate_code => 'Activer un code';

  @override
  String get subscription_page_activate_code_description =>
      'Saisissez votre clé de licence ou d’abonnement pour mettre à niveau votre compte.';

  @override
  String get subscription_page_activate_button => 'Activer';

  @override
  String get subscription_page_premium_title => 'Premium';

  @override
  String get subscription_page_premium_description =>
      'Pour les particuliers & passionnés';

  @override
  String get subscription_page_pro_title => 'Professionnel';

  @override
  String get subscription_page_pro_description =>
      'Pour les entreprises & cultivateurs pro';

  @override
  String get subscription_page_monthly => 'Mensuel';

  @override
  String get subscription_page_yearly => 'Annuel';

  @override
  String get subscription_page_lifetime => 'À Vie';

  @override
  String get subscription_page_choose_button => 'Choisir';

  @override
  String get subscription_page_feature_unlimited_sensors =>
      'Accès illimité aux capteurs';

  @override
  String get subscription_page_feature_history_30_days =>
      'Historique complet (30j)';

  @override
  String get subscription_page_feature_priority_support =>
      'Support prioritaire';

  @override
  String get subscription_page_feature_custom_alerts =>
      'Alertes personnalisées';

  @override
  String get subscription_page_feature_multi_installations =>
      'Gestion multi-installations';

  @override
  String get subscription_page_feature_advanced_ai => 'Analyses IA avancées';

  @override
  String get subscription_page_feature_data_export =>
      'Export de données (CSV/Excel)';

  @override
  String get subscription_page_feature_technical_support_24_7 =>
      'Support technique 24/7';

  @override
  String get subscription_page_offer_free_trial => '2 mois offerts';

  @override
  String get subscription_page_offer_discount => '15% OFF';

  @override
  String get subscription_page_hardware_title => 'Nos Packs Matériel IoT';

  @override
  String get subscription_page_hardware_description =>
      'Des solutions clé en main, pré-assemblés et calibrés, incluant 1 an d’abonnement Cultivateur offert.';

  @override
  String get subscription_page_essential_pack => 'Pack Essentiel';

  @override
  String get subscription_page_essential_pack_description =>
      'Le kit de survie (Monitoring pH/EC/Temp)';

  @override
  String get subscription_page_comfort_pack => 'Pack Confort';

  @override
  String get subscription_page_comfort_pack_description =>
      'L’autonomie totale avec gestion du pH.';

  @override
  String get subscription_page_total_ia_pack => 'Pack Total IA';

  @override
  String get subscription_page_total_ia_pack_description =>
      'Haute performance et vision par ordinateur.';

  @override
  String get subscription_page_order_button => 'Commander';

  @override
  String get subscription_page_feature_ph_ec_probe =>
      'Sonde pH & EC Industrielle';

  @override
  String get subscription_page_feature_water_temp_sensor =>
      'Capteur Température Eau';

  @override
  String get subscription_page_feature_water_level_sensor =>
      'Capteur Niveau (Anti-sec)';

  @override
  String get subscription_page_feature_irrigation_control =>
      'Contrôle Pompe Irrigation';

  @override
  String get subscription_page_feature_waterproof_case =>
      'Boîtier Étanche IP65';

  @override
  String get subscription_page_feature_auto_dosing => 'Dosage Automatique';

  @override
  String get subscription_page_feature_air_sensors =>
      'Capteurs Air (Temp/Hum/Lux)';

  @override
  String get subscription_page_feature_ph_regulation_pumps =>
      'Pompes de régulation pH';

  @override
  String get subscription_page_feature_auto_nutrient_doser =>
      'Doseur Nutriments Auto';

  @override
  String get subscription_page_feature_led_relay => 'Relais Éclairage LED';

  @override
  String get subscription_page_feature_plug_and_play =>
      'Installation Plug & Play';

  @override
  String get subscription_page_feature_co2_camera => 'Caméra CO2 & Débitmètre';

  @override
  String get subscription_page_feature_ai_camera =>
      'Caméra IA (Time-lapse/Santé)';

  @override
  String get subscription_page_feature_galvanic_isolation =>
      'Isolation Galvanique Pro';

  @override
  String get subscription_page_feature_agronomist_subscription =>
      'Abonnement Agronome (1 an)';

  @override
  String get subscription_page_feature_three_year_warranty => 'Garantie 3 ans';

  @override
  String get common_edit => 'Modifier';

  @override
  String get common_delete => 'Supprimer';

  @override
  String get stock_page_title => 'Suivi des stocks';

  @override
  String get stock_page_items_label => 'articles';

  @override
  String get stock_page_empty => 'Aucun article en stock.';

  @override
  String get stock_page_alert_label => 'Alertes';

  @override
  String get stock_card_expiry => 'Expiration';

  @override
  String get stock_card_threshold => 'Seuil';

  @override
  String get stock_card_total_value => 'Valeur totale';

  @override
  String get stock_card_unit_cost => 'Coût unitaire';

  @override
  String get stock_status_faible => 'Faible';

  @override
  String get stock_status_moyen => 'Moyen';

  @override
  String get stock_status_optimal => 'Optimal';

  @override
  String get stock_status_rupture => 'Rupture';

  @override
  String get parcel_page_title => 'Gestion des parcelles';

  @override
  String get parcel_page_count_label => 'parcelles';

  @override
  String get parcel_page_empty => 'Aucune parcelle trouvée.';

  @override
  String get parcel_page_inactive_label => 'Inactives';

  @override
  String get parcel_status_active => 'Active';

  @override
  String get parcel_status_inactive => 'Inactive';

  @override
  String get parcel_status_planned => 'Planifiée';

  @override
  String get parcel_card_commissioned => 'Mise en service';

  @override
  String get parcel_card_plants => 'Plantes';

  @override
  String get parcel_inactive_section => 'Parcelles inactives';

  @override
  String get parcel_label_plants => 'plantes';

  @override
  String get parcel_summary_title => 'Parcelles';

  @override
  String get parcel_summary_parcels_label => 'parcelles';

  @override
  String get parcel_summary_plants_label => 'plantes';

  @override
  String get parcel_summary_inactive_label => 'inactives';

  @override
  String get community_page_title => 'Communauté';

  @override
  String get community_page_subtitle => 'Partagez vos expériences';

  @override
  String get community_search_hint => 'Rechercher...';

  @override
  String get community_filter_all => 'Tous';

  @override
  String get community_reset_filters => 'Réinitialiser les filtres';

  @override
  String get community_empty => 'Aucun article trouvé.';

  @override
  String get community_articles_count_label => 'articles';

  @override
  String get community_stat_articles => 'Articles';

  @override
  String get community_stat_categories => 'Catégories';

  @override
  String get community_stat_mine => 'Les miens';

  @override
  String get community_summary_title => 'Communauté';

  @override
  String get community_summary_subtitle => 'Dernières publications';

  @override
  String get community_summary_new_label => 'Nouveau';

  @override
  String get community_summary_empty => 'Aucune publication récente.';

  @override
  String get article_read_min => 'min de lecture';

  @override
  String get article_my_article => 'Mon article';

  @override
  String get article_action_edit => 'Modifier';

  @override
  String get article_action_delete => 'Supprimer';

  @override
  String get article_detail_read_label => 'min de lecture';

  @override
  String get article_detail_tags => 'Tags';

  @override
  String get article_detail_you => 'Vous';

  @override
  String get article_form_back => 'Retour';

  @override
  String get article_form_title_label => 'Titre';

  @override
  String get article_form_title_hint => 'Titre de l\'article';

  @override
  String get article_form_title_required => 'Le titre est requis';

  @override
  String get article_form_content_label => 'Contenu';

  @override
  String get article_form_content_hint => 'Contenu de l\'article';

  @override
  String get article_form_content_min =>
      'Le contenu doit faire au moins 10 caractères';

  @override
  String get article_form_category => 'Catégorie';

  @override
  String get article_form_image_label => 'Image';

  @override
  String get article_form_image_hint => 'URL de l\'image';

  @override
  String get article_form_tags_label => 'Tags';

  @override
  String get article_form_tags_hint => 'tag1, tag2, tag3';

  @override
  String get article_form_publish => 'Publier';

  @override
  String get article_form_save => 'Enregistrer';

  @override
  String get sidebar_menu_label => 'Menu';

  @override
  String get login_tagline =>
      'Gérez vos cultures hydroponiques avec précision.';

  @override
  String get login_feature_monitoring => 'Monitoring temps réel';

  @override
  String get login_feature_alerts => 'Alertes intelligentes';

  @override
  String get login_feature_community => 'Communauté';

  @override
  String get forgot_password_link => 'Mot de passe oublié ?';

  @override
  String get forgot_password_title => 'Réinitialiser le mot de passe';

  @override
  String get forgot_password_subtitle =>
      'Saisissez votre adresse email et nous vous enverrons un lien pour réinitialiser votre mot de passe.';

  @override
  String get forgot_password_email_label => 'Adresse email';

  @override
  String get forgot_password_send => 'Envoyer le lien';

  @override
  String get forgot_password_success_title => 'Email envoyé !';

  @override
  String get forgot_password_success_message =>
      'Si cette adresse est associée à un compte, vous recevrez un lien de réinitialisation dans quelques instants.';

  @override
  String get forgot_password_close => 'Retour à la connexion';

  @override
  String get stock_form_back => 'Retour';

  @override
  String get stock_form_title_create => 'Nouvel article';

  @override
  String get stock_form_title_edit => 'Modifier l\'article';

  @override
  String get stock_form_field_name => 'Nom *';

  @override
  String get stock_form_field_name_hint => 'Nom de l\'article';

  @override
  String get stock_form_field_name_required => 'Le nom est requis';

  @override
  String get stock_form_field_category => 'Catégorie *';

  @override
  String get stock_form_field_quantity => 'Quantité *';

  @override
  String get stock_form_field_quantity_required => 'Obligatoire';

  @override
  String get stock_form_field_quantity_invalid => 'Nombre entier requis';

  @override
  String get stock_form_field_unit => 'Unité';

  @override
  String get stock_form_field_threshold => 'Seuil d\'alerte';

  @override
  String get stock_form_field_threshold_invalid => 'Nombre entier requis';

  @override
  String get stock_form_field_brand => 'Marque';

  @override
  String get stock_form_field_price => 'Prix unitaire (€)';

  @override
  String get stock_form_field_price_invalid => 'Nombre invalide';

  @override
  String get stock_form_field_notes => 'Notes';

  @override
  String get stock_form_save => 'Enregistrer';

  @override
  String get stock_form_create => 'Ajouter au stock';

  @override
  String get parcel_form_back => 'Retour';

  @override
  String get parcel_form_title_create => 'Nouvelle parcelle';

  @override
  String get parcel_form_title_edit => 'Modifier la parcelle';

  @override
  String get parcel_form_field_name => 'Nom *';

  @override
  String get parcel_form_field_name_hint => 'Nom de la parcelle';

  @override
  String get parcel_form_field_name_required => 'Champ obligatoire';

  @override
  String get parcel_form_field_type => 'Type';

  @override
  String get parcel_form_field_status => 'Statut';

  @override
  String get parcel_form_field_location => 'Localisation';

  @override
  String get parcel_form_field_plants => 'Nombre de plantes';

  @override
  String get parcel_form_field_plants_invalid => 'Nombre entier requis';

  @override
  String get parcel_form_field_date => 'Mise en service';

  @override
  String get parcel_form_save => 'Enregistrer';

  @override
  String get parcel_form_create => 'Créer la parcelle';
}
