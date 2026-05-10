import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class DashboardContainer extends StatefulWidget {
  final String title;
  final String defaultContent;
  final bool isEditMode;

  const DashboardContainer({
    super.key,
    this.title = '',
    this.defaultContent = '',
    this.isEditMode = false,
  });

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: colors.divider, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                widget.defaultContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: colors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  color: colors.textSecondary,
                  backgroundColor: colors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
