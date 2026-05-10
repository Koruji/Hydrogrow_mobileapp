import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/parcel.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class ParcelItemCard extends StatelessWidget {
  final Parcel parcel;
  final VoidCallback? onTap;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const ParcelItemCard({
    Key? key,
    required this.parcel,
    this.onTap,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final translate = AppLocalizations.of(context)!;
    final statusColor = parcel.getStatusColor();
    final statusLabel = parcel.getStatusLabel();
    final isInactive = parcel.status == 'inactive';

    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isInactive ? statusColor.withValues(alpha: 0.3) : colors.divider,
              width: isInactive ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTypeIcon(statusColor),
                    const SizedBox(width: 16),
                    Expanded(child: _buildParcelInfo(colors, statusLabel, statusColor)),
                    const SizedBox(width: 12),
                    _buildPlantCount(colors, translate),
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

  Widget _buildTypeIcon(Color statusColor) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Icon(parcel.getTypeIcon(), size: 32, color: statusColor),
    );
  }

  Widget _buildParcelInfo(AppColorsExtension colors, String statusLabel, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          parcel.name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.textPrimary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on, size: 12, color: colors.textSecondary),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                parcel.location,
                style: TextStyle(fontSize: 12, color: colors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          parcel.type,
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

  Widget _buildPlantCount(AppColorsExtension colors, AppLocalizations translate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          parcel.nbPlant.toString(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colors.textPrimary),
        ),
        Text(translate.parcel_card_plants, style: TextStyle(fontSize: 12, color: colors.textSecondary)),
      ],
    );
  }

  Widget _buildDetailsSection(AppColorsExtension colors, AppLocalizations translate) {
    final commissioningStr =
        '${parcel.commissioningDate.day.toString().padLeft(2, '0')}/'
        '${parcel.commissioningDate.month.toString().padLeft(2, '0')}/'
        '${parcel.commissioningDate.year}';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: colors.textSecondary),
              const SizedBox(width: 6),
              Text(
                '${translate.parcel_card_commissioned} $commissioningStr',
                style: TextStyle(fontSize: 12, color: colors.textSecondary),
              ),
            ],
          ),
          if (parcel.notes != null && parcel.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.notes, size: 14, color: colors.textSecondary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    parcel.notes!,
                    style: TextStyle(fontSize: 12, color: colors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
