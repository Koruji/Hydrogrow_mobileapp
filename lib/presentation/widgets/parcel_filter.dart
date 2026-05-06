import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class ParcelFiltersWidget extends StatelessWidget {
  final List<String> types;
  final String selectedType;
  final String selectedStatus;
  final Function(String) onTypeChanged;
  final Function(String) onStatusChanged;

  const ParcelFiltersWidget({
    Key? key,
    required this.types,
    required this.selectedType,
    required this.selectedStatus,
    required this.onTypeChanged,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statuses = ['Tous', 'active', 'planned', 'inactive'];
    final statusLabels = {
      'Tous': 'TOUS',
      'active': 'ACTIVE',
      'planned': 'PLANIFIÉE',
      'inactive': 'INACTIVE',
    };

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButton<String>(
                  value: selectedType,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: types.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onTypeChanged(value);
                  },
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.menu),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statut',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButton<String>(
                  value: selectedStatus,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: statuses.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(
                        statusLabels[status] ?? status.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) onStatusChanged(value);
                  },
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.menu),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
