import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/widgets/alert_message.dart';
import 'package:hydrogrow/presentation/widgets/app_bar.dart';
import 'package:hydrogrow/presentation/widgets/dashboard_container.dart';
import 'package:hydrogrow/presentation/widgets/reordable_container_list.dart';
import 'package:hydrogrow/presentation/widgets/side_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isEditMode = false;
  bool isPremium = false;

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    final containersTitle = [
      translate.dashboard_block_1_title,
      translate.dashboard_block_2_title,
      translate.dashboard_block_3_title,
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppBarComponent(
        isEditMode: isEditMode,
        onMenuPressed: () {
          _openDrawer();
        },
        onEditPressed: () {
          setState(() {
            isEditMode = !isEditMode;
          });
        },
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: SideBarComponent(currentRoute: '/dashboard'),
      ),
      body: Column(
        children: [
          if (isEditMode)
            AlertMessage(
              icon: Icons.warning_amber_rounded,
              color: AppColors.warning,
              message: translate.dashboard_alert_message,
            ),
          Expanded(
            child: ReorderableContainerList(
              titles: containersTitle,
              storageKey: 'dashboard_container_order',
              isEditMode: isEditMode,
              headerWidget: null,
              itemBuilder: (title) {
                return DashboardContainer(key: ValueKey(title), title: title);
              },
            ),
          ),
          if (!isPremium)
            AlertMessage(
              icon: Icons.star_rounded,
              color: AppColors.notification,
              message: translate.dashboard_premium,
            ),
        ],
      ),
    );
  }
}
