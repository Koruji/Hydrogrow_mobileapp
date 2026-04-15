import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/widgets/alert_message.dart';
import 'package:hydrogrow/presentation/widgets/dashboard_container.dart';
import 'package:hydrogrow/presentation/widgets/reordable_container_list.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isEditMode = false;
  bool isPremium = false;
  Map<String, dynamic>? user;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Déplacée ici

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final user = Provider.of<AuthProvider>(context).user;
    final containersTitle = [
      translate.dashboard_block_1_title,
      translate.dashboard_block_2_title,
      translate.dashboard_block_3_title,
    ];

    return AppScaffold(
      currentRoute: '/dashboard',
      isEditMode: isEditMode,
      onEditPressed: () {
        if (mounted) {
          setState(() {
            isEditMode = !isEditMode;
          });
        }
      },
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              '${translate.dashboard_welcome} ${user?['login'] ?? ''} !',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
