import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/parcel.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class ParcelSummaryWidget extends StatelessWidget {
  final int total;
  final int active;
  final int planned;
  final int inactive;
  final int totalPlants;
  final List<Parcel> inactiveParcels;
  final VoidCallback? onTap;

  const ParcelSummaryWidget({
    Key? key,
    required this.total,
    required this.active,
    required this.planned,
    required this.inactive,
    required this.totalPlants,
    required this.inactiveParcels,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildStatCards(context),
            if (inactiveParcels.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildInactiveSection(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Suivi des parcelles',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.textPrimary)),
            const SizedBox(height: 4),
            Text('$total parcelle(s) · $totalPlants plantes',
                style: TextStyle(fontSize: 12, color: colors.textSecondary)),
          ],
        ),
        if (inactive > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: colors.warning, borderRadius: BorderRadius.circular(12)),
            child: Text('$inactive inactive(s)',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
      ],
    );
  }

  Widget _buildStatCards(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Expanded(child: _buildStatCard(context, value: active.toString(), label: 'Actives', color: colors.success, icon: Icons.check_circle)),
        const SizedBox(width: 10),
        Expanded(child: _buildStatCard(context, value: planned.toString(), label: 'Planifiées', color: colors.notification, icon: Icons.schedule)),
        const SizedBox(width: 10),
        Expanded(child: _buildStatCard(context, value: inactive.toString(), label: 'Inactives', color: colors.warning, icon: Icons.pause_circle)),
        const SizedBox(width: 10),
        Expanded(child: _buildStatCard(context, value: totalPlants.toString(), label: 'Plantes', color: colors.menu, icon: Icons.eco)),
      ],
    );
  }

  Widget _buildInactiveSection(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1, color: colors.divider),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, size: 14, color: colors.warning),
            const SizedBox(width: 6),
            Text('Parcelles inactives',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.warning)),
          ],
        ),
        const SizedBox(height: 8),
        ...inactiveParcels.map((parcel) => _buildInactiveParcelRow(context, parcel)),
      ],
    );
  }

  Widget _buildInactiveParcelRow(BuildContext context, Parcel parcel) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(parcel.getTypeIcon(), size: 16, color: colors.warning),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(parcel.name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.textPrimary)),
                Text(parcel.location,
                    style: TextStyle(fontSize: 11, color: colors.textSecondary),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: colors.warning.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(parcel.type,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: colors.warning)),
          ),
        ],
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
