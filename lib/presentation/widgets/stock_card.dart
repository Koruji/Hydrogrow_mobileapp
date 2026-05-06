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
              color: isLow ? statusColor.withOpacity(0.3) : AppColors.divider,
              width: isLow ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              // En-tête avec image et infos principales
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image/Icône
                    _buildProductImage(),
                    const SizedBox(width: 16),
                    // Infos principales
                    Expanded(
                      child: _buildProductInfo(statusLabel, statusColor),
                    ),
                    const SizedBox(width: 12),
                    // Quantité affichée
                    _buildQuantityDisplay(isLow),
                    if (onEditPressed != null || onDeletePressed != null)
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context) => [
                            if (onEditPressed != null)
                              PopupMenuItem(
                                child: const Text(
                                  'Modifier',
                                  style: TextStyle(fontSize: 12),
                                ),
                                onTap: onEditPressed,
                              ),
                            if (onDeletePressed != null)
                              PopupMenuItem(
                                child: const Text(
                                  'Supprimer',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                                onTap: onDeletePressed,
                              ),
                          ],
                          child: Icon(
                            Icons.more_vert,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Divider
              const Divider(height: 1, color: AppColors.divider),
              // Détails supplémentaires
              _buildDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: item.imageUrl != null
          ? Image.asset(item.imageUrl!, fit: BoxFit.cover)
          : Icon(
              _getCategoryIcon(item.category),
              size: 40,
              color: AppColors.textSecondary,
            ),
    );
  }

  Widget _buildProductInfo(String statusLabel, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          item.brand,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          item.category,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        // Statut badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor.withOpacity(0.4)),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityDisplay(bool isLow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          item.quantity.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isLow ? AppColors.warning : AppColors.textPrimary,
          ),
        ),
        Text(
          item.unit,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailColumn(
                label: 'Seuil min.',
                value: '${item.minThreshold} ${item.unit}',
              ),
              _buildDetailColumn(
                label: 'Coût unitaire',
                value: '${item.costPerUnit.toStringAsFixed(2)}${item.currency}',
                color: AppColors.menu,
              ),
              _buildDetailColumn(
                label: 'Valeur totale',
                value:
                    '${item.getTotalValue().toStringAsFixed(2)}${item.currency}',
              ),
            ],
          ),
          if (item.expirationDate != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Expiration: ${item.expirationDate}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailColumn({
    required String label,
    required String value,
    Color color = AppColors.textPrimary,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Semences':
        return Icons.eco;
      case 'Fertilisants':
        return Icons.grain;
      case 'Additifs':
        return Icons.science;
      case 'Équipements':
        return Icons.build;
      default:
        return Icons.inventory_2;
    }
  }
}
