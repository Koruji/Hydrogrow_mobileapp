import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/presentation/widgets/app_bar.dart';
import 'package:hydrogrow/presentation/widgets/side_bar.dart';

class AppScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget body;
  final String currentRoute;
  final bool isEditMode;
  final VoidCallback? onEditPressed;

  AppScaffold({
    super.key,
    required this.currentRoute,
    required this.body,
    this.isEditMode = false,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppBarComponent(
        isEditMode: isEditMode,
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onEditPressed: onEditPressed,
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: SideBarComponent(currentRoute: currentRoute),
      ),
      body: body,
    );
  }
}
