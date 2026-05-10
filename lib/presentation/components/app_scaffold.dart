import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/presentation/widgets/app_bar.dart';
import 'package:hydrogrow/presentation/widgets/side_bar.dart';

class AppScaffold extends StatefulWidget {
  final String currentRoute;
  final Widget body;
  final bool isEditMode;
  final VoidCallback? onEditPressed;
  final bool showDrawer;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.currentRoute,
    required this.body,
    this.isEditMode = false,
    this.onEditPressed,
    this.showDrawer = true,
    this.floatingActionButton,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: context.colors.background,
      appBar: AppBarComponent(
        isEditMode: widget.isEditMode,
        onMenuPressed: widget.showDrawer
            ? () {
                if (mounted) _scaffoldKey.currentState?.openDrawer();
              }
            : null,
        onEditPressed: widget.onEditPressed,
      ),
      drawer: widget.showDrawer
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: SideBarComponent(currentRoute: widget.currentRoute),
            )
          : null,
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
