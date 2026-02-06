import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/presentation/widgets/app_bar.dart';
import 'package:hydrogrow/presentation/widgets/side_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      appBar: AppBarComponent(
        onMenuPressed: () {
          _openDrawer();
        },
        onEditPressed: () {
          // Action pour le bouton d'édition
        },
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: SideBarComponent(currentRoute: '/dashboard'),
      ),
      body: Center(
        child: Text('Votre contenu ici'),
      ),
    );
  }
}