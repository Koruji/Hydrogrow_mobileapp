import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class StockFiltersWidget extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final String selectedStatus;
  final Function(String) onCategoryChanged;
  final Function(String) onStatusChanged;

  const StockFiltersWidget({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.selectedStatus,
    required this.onCategoryChanged,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statuses = ['Tous', 'optimal', 'moyen', 'faible', 'rupture'];

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Dropdown Catégorie
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catégorie',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButton<String>(
                  value: selectedCategory,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onCategoryChanged(value);
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.menu),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Dropdown Statut
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
                        status.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onStatusChanged(value);
                    }
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
