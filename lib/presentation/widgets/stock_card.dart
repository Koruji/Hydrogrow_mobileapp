import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/stock.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class StockItemCard extends StatelessWidget {
  final Stock item;
  final VoidCallback? onTap;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const StockItemCard({
    Key? key,
    required this.item,
    this.onTap,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final translate = AppLocalizations.of(context)!;
    final statusColor = item.getStatusColor();
    final statusLabel = item.getStatusLabel(translate);
    final isLow = item.isCritical();

    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isLow ? statusColor.withValues(alpha: 0.3) : colors.divider,
              width: isLow ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(colors),
                    const SizedBox(width: 16),
                    Expanded(child: _buildProductInfo(colors, statusLabel, statusColor)),
                    const SizedBox(width: 12),
                    _buildQuantityDisplay(colors, isLow),
                    if (onEditPressed != null || onDeletePressed != null)
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context) => [
                            if (onEditPressed != null)
                              PopupMenuItem(
                                child: Text(translate.common_edit, style: const TextStyle(fontSize: 12)),
                                onTap: onEditPressed,
                              ),
                            if (onDeletePressed != null)
                              PopupMenuItem(
                                child: Text(translate.common_delete, style: const TextStyle(color: Colors.red, fontSize: 12)),
                                onTap: onDeletePressed,
                              ),
                          ],
                          child: Icon(Icons.more_vert, size: 20, color: colors.textSecondary),
                        ),
                      ),
                  ],
                ),
              ),
              Divider(height: 1, color: colors.divider),
              _buildDetailsSection(colors, translate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(AppColorsExtension colors) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.divider),
      ),
      child: item.imageUrl != null
          ? Image.asset(item.imageUrl!, fit: BoxFit.cover)
          : Icon(_getCategoryIcon(item.category), size: 40, color: colors.textSecondary),
    );
  }

  Widget _buildProductInfo(AppColorsExtension colors, String statusLabel, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.textPrimary),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(item.brand, style: TextStyle(fontSize: 12, color: colors.textSecondary)),
        const SizedBox(height: 4),
        Text(
          _categoryLabel(item.category),
          style: TextStyle(fontSize: 11, color: colors.textSecondary, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor.withValues(alpha: 0.4)),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityDisplay(AppColorsExtension colors, bool isLow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          item.quantity.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isLow ? AppColors.warning : colors.textPrimary,
          ),
        ),
        Text(_unitLabel(item.unit), style: TextStyle(fontSize: 12, color: colors.textSecondary)),
      ],
    );
  }

  Widget _buildDetailsSection(AppColorsExtension colors, AppLocalizations translate) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailColumn(colors, label: translate.stock_card_threshold, value: '${item.minThreshold} ${_unitLabel(item.unit)}'),
              _buildDetailColumn(colors,
                  label: translate.stock_card_unit_cost,
                  value: '${item.costPerUnit.toStringAsFixed(2)}${item.currency}',
                  color: colors.menu),
              _buildDetailColumn(colors,
                  label: translate.stock_card_total_value,
                  value: '${item.getTotalValue().toStringAsFixed(2)}${item.currency}'),
            ],
          ),
          if (item.expirationDate != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: colors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  '${translate.stock_card_expiry} ${item.expirationDate}',
                  style: TextStyle(fontSize: 12, color: colors.textSecondary),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailColumn(AppColorsExtension colors, {
    required String label,
    required String value,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: colors.textSecondary)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color ?? colors.textPrimary),
        ),
      ],
    );
  }

  String _unitLabel(String unit) {
    switch (unit) {
      case 'qty': return 'unité(s)';
      case 'g': return 'g';
      case 'kg': return 'kg';
      case 'ml': return 'ml';
      case 'l': return 'l';
      default: return unit;
    }
  }

  String _categoryLabel(String category) {
    switch (category) {
      case 'seed': return 'Semences';
      case 'nutrient': return 'Engrais / Nutriments';
      case 'ph_control': return 'Correcteur pH';
      case 'substrate': return 'Substrat';
      case 'equipment': return 'Équipement';
      case 'other': return 'Autre';
      default: return category;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'seed': return Icons.eco;
      case 'nutrient': return Icons.grain;
      case 'ph_control': return Icons.science;
      case 'substrate': return Icons.landscape;
      case 'equipment': return Icons.build;
      default: return Icons.inventory_2;
    }
  }
}
