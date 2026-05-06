import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';

class RGPDPage extends StatelessWidget {
  const RGPDPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return AppScaffold(
      currentRoute: '/account/rgpd',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.icon),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  translate.account_page_rgpd_title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            _buildRGPDSection(
              title: "Minimisation des données",
              content: translate.account_page_rgpd_data_minimization
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
              context: context,
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              title: "Limitation des finalités",
              content: translate.account_page_rgpd_purpose_limitation
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
              context: context,
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              title: "Durée de conservation",
              content: translate.account_page_rgpd_retention
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
              context: context,
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              title: "Sécurité",
              content: translate.account_page_rgpd_security
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
              context: context,
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              title: "Transparence",
              content: translate.account_page_rgpd_transparency
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRGPDSection({
    required String title,
    required String content,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: AppColors.menu, width: 3)),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
