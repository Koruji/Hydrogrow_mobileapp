import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class StockSummaryWidget extends StatelessWidget {
  final int total;
  final int optimal;
  final int moyen;
  final int faible;
  final int rupture;
  final VoidCallback? onTap;

  const StockSummaryWidget({
    Key? key,
    required this.total,
    required this.optimal,
    required this.moyen,
    required this.faible,
    required this.rupture,
    this.onTap,
  }) : super(key: key);

  int get alertCount => faible + rupture;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final translate = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(translate.stock_page_title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                    const SizedBox(height: 4),
                    Text('$total ${translate.stock_page_items_label}',
                        style: TextStyle(fontSize: 12, color: colors.textSecondary)),
                  ],
                ),
                if (alertCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: colors.warning, borderRadius: BorderRadius.circular(12)),
                    child: Text('$alertCount ${translate.stock_page_alert_label}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, value: optimal.toString(), label: translate.stock_status_optimal, color: colors.success, icon: Icons.check_circle)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard(context, value: moyen.toString(), label: translate.stock_status_moyen, color: colors.notification, icon: Icons.info_outline)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard(context, value: faible.toString(), label: translate.stock_status_faible, color: colors.notification, icon: Icons.warning)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard(context, value: rupture.toString(), label: translate.stock_status_rupture, color: colors.warning, icon: Icons.error)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {
    required String value,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 10, color: colors.textSecondary), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
