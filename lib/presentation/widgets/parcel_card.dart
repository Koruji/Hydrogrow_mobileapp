import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/parcel.dart';
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
              color: isInactive
                  ? statusColor.withOpacity(0.3)
                  : AppColors.divider,
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
                    Expanded(
                      child: _buildParcelInfo(statusLabel, statusColor),
                    ),
                    const SizedBox(width: 12),
                    _buildPlantCount(),
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
              const Divider(height: 1, color: AppColors.divider),
              _buildDetailsSection(),
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
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Icon(
        parcel.getTypeIcon(),
        size: 32,
        color: statusColor,
      ),
    );
  }

  Widget _buildParcelInfo(String statusLabel, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          parcel.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on, size: 12, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                parcel.location,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          parcel.type,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
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

  Widget _buildPlantCount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          parcel.nbPlant.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          'plantes',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
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
              Icon(
                Icons.calendar_today,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                'Mise en service : $commissioningStr',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
          if (parcel.notes != null && parcel.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notes,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    parcel.notes!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
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
