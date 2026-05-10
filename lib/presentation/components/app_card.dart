import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: padding, child: child),
    );
  }
}
