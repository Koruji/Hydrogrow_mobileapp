import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool _showPremium = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/account/subscription',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentSubscriptionCard(),
            _buildSubscriptionToggle(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _showPremium
                  ? _buildSubscriptionTier(isPremium: true)
                  : _buildSubscriptionTier(isPremium: false),
            ),
            _buildHardwarePacksSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentSubscriptionCard() {
    final translate = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate.subscription_page_current_subscription,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Chip(
                  label: Text(
                    "FREEMIUM",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: AppColors.success,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  translate.subscription_page_status,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(translate.subscription_page_active_status),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  translate.subscription_page_next_due,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(translate.subscription_page_not_applicable),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              translate.subscription_page_activate_code,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              translate.subscription_page_activate_code_description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: "XXXX - XXXX - XXXX - XXXX",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.menu,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  translate.subscription_page_activate_button,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionToggle() {
    final translate = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _showPremium = true),
              style: ElevatedButton.styleFrom(
                backgroundColor: _showPremium
                    ? AppColors.menu
                    : Colors.grey[300],
                foregroundColor: _showPremium
                    ? Colors.white
                    : AppColors.textPrimary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              child: Text(
                translate.subscription_page_premium_title,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _showPremium = false),
              style: ElevatedButton.styleFrom(
                backgroundColor: !_showPremium
                    ? AppColors.notification
                    : Colors.grey[300],
                foregroundColor: !_showPremium
                    ? Colors.white
                    : AppColors.textPrimary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              child: Text(
                translate.subscription_page_pro_title,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionTier({required bool isPremium}) {
    final translate = AppLocalizations.of(context)!;
    final features = isPremium
        ? [
            translate.subscription_page_feature_unlimited_sensors,
            translate.subscription_page_feature_history_30_days,
            translate.subscription_page_feature_priority_support,
            translate.subscription_page_feature_custom_alerts,
          ]
        : [
            translate.subscription_page_feature_unlimited_sensors,
            translate.subscription_page_feature_multi_installations,
            translate.subscription_page_feature_advanced_ai,
            translate.subscription_page_feature_data_export,
            translate.subscription_page_feature_technical_support_24_7,
          ];

    final pricing = isPremium
        ? [
            {
              "period": translate.subscription_page_monthly,
              "price": "9.99€",
              "unit": "mois",
            },
            {
              "period": translate.subscription_page_yearly,
              "price": "99.99€",
              "unit": "an",
              "offer": translate.subscription_page_offer_free_trial,
            },
            {
              "period": translate.subscription_page_lifetime,
              "price": "199€",
              "unit": "une fois",
            },
          ]
        : [
            {
              "period": translate.subscription_page_monthly,
              "price": "49.99€",
              "unit": "mois",
            },
            {
              "period": translate.subscription_page_yearly,
              "price": "499.99€",
              "unit": "an",
              "offer": translate.subscription_page_offer_discount,
            },
          ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPremium
                ? translate.subscription_page_premium_title
                : translate.subscription_page_pro_title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isPremium ? AppColors.textPrimary : AppColors.notification,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            isPremium
                ? translate.subscription_page_premium_description
                : translate.subscription_page_pro_description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: features
                .map(
                  (feature) => Chip(
                    label: Text(feature, style: const TextStyle(fontSize: 12)),
                    backgroundColor: AppColors.background,
                    labelStyle: const TextStyle(color: AppColors.textPrimary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.divider),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: pricing
                .map(
                  (p) => _buildCompactPriceCard(
                    p["period"]!,
                    p["price"]!,
                    p["unit"]!,
                    offer: p["offer"],
                    hasBorder: p["unit"] != "an",
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactPriceCard(
    String period,
    String price,
    String unit, {
    String? offer,
    bool hasBorder = true,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: hasBorder ? Border.all(color: AppColors.divider) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            period,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            "$price/$unit",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.menu,
            ),
            textAlign: TextAlign.center,
          ),
          if (offer != null)
            Text(
              offer,
              style: const TextStyle(color: AppColors.success, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(color: AppColors.menu),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "subscription_page_choose_button",
                style: TextStyle(fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHardwarePacksSection() {
    final translate = AppLocalizations.of(context)!;
    final packs = [
      {
        "title": translate.subscription_page_essential_pack,
        "description": translate.subscription_page_essential_pack_description,
        "price": "199€",
        "features": [
          translate.subscription_page_feature_ph_ec_probe,
          translate.subscription_page_feature_water_temp_sensor,
          translate.subscription_page_feature_water_level_sensor,
          translate.subscription_page_feature_irrigation_control,
          translate.subscription_page_feature_waterproof_case,
          translate.subscription_page_feature_auto_dosing,
        ],
      },
      {
        "title": translate.subscription_page_comfort_pack,
        "description": translate.subscription_page_comfort_pack_description,
        "price": "399€ - 449€",
        "features": [
          "${translate.subscription_page_essential_pack} + ${translate.subscription_page_feature_air_sensors}",
          translate.subscription_page_feature_ph_regulation_pumps,
          translate.subscription_page_feature_auto_nutrient_doser,
          translate.subscription_page_feature_led_relay,
          translate.subscription_page_feature_plug_and_play,
        ],
      },
      {
        "title": translate.subscription_page_total_ia_pack,
        "description": translate.subscription_page_total_ia_pack_description,
        "price": "899€",
        "features": [
          "${translate.subscription_page_comfort_pack} + ${translate.subscription_page_essential_pack}",
          translate.subscription_page_feature_co2_camera,
          translate.subscription_page_feature_ai_camera,
          translate.subscription_page_feature_galvanic_isolation,
          translate.subscription_page_feature_agronomist_subscription,
          translate.subscription_page_feature_three_year_warranty,
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate.subscription_page_hardware_title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                translate.subscription_page_hardware_description,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: packs
                .map(
                  (pack) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: _buildHardwarePackCard(
                        pack["title"] as String,
                        pack["description"] as String,
                        pack["price"] as String,
                        pack["features"] as List<String>,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHardwarePackCard(
    String title,
    String description,
    String price,
    List<String> features,
  ) {
    return AppCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(description, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 10),
          Text(
            price,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.menu,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.check, size: 14, color: AppColors.success),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(feature, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.menu,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "subscription_page_order_button",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
