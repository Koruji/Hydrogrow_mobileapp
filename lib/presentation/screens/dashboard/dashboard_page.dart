import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/widgets/alert_message.dart';
import 'package:hydrogrow/presentation/widgets/dashboard_container.dart';
import 'package:hydrogrow/presentation/widgets/reordable_container_list.dart';
import 'package:hydrogrow/presentation/widgets/stock_summary_dashboard.dart';
import 'package:hydrogrow/presentation/widgets/parcel_summary_dashboard.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:hydrogrow/presentation/controllers/stock_controller.dart';
import 'package:hydrogrow/presentation/controllers/parcel_controller.dart';
import 'package:hydrogrow/data/mock/stock_mock.dart';
import 'package:hydrogrow/data/mock/parcel_mock.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isEditMode = false;
  bool isPremium = false;
  Map<String, dynamic>? user;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late StockController _stockController;
  late ParcelController _parcelController;

  @override
  void initState() {
    super.initState();
    _stockController = StockController();
    _stockController.initialize(mockStockItems);
    _parcelController = ParcelController();
    _parcelController.initialize(mockParcels);
  }

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
      'Stocks',
      'Parcelles',
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
                // Retourner un widget différent selon le titre
                if (title == 'Stocks') {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildStockSummaryContainer(),
                  );
                } else if (title == 'Parcelles') {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildParcelSummaryContainer(),
                  );
                } else {
                  return DashboardContainer(key: ValueKey(title), title: title);
                }
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

  Widget _buildParcelSummaryContainer() {
    final stats = _parcelController.getStatistics();
    final inactiveParcels = mockParcels.where((p) => p.status == 'inactive').toList();

    return ParcelSummaryWidget(
      key: const ValueKey('parcel-summary'),
      total: stats.total,
      active: stats.active,
      planned: stats.planned,
      inactive: stats.inactive,
      totalPlants: stats.totalPlants,
      inactiveParcels: inactiveParcels,
      onTap: () {
        Navigator.pushNamed(context, '/parcels').then((_) {
          if (mounted) {
            setState(() {
              _parcelController = ParcelController();
              _parcelController.initialize(mockParcels);
            });
          }
        });
      },
    );
  }

  Widget _buildStockSummaryContainer() {
    final stats = _stockController.getStatistics();

    return StockSummaryWidget(
      key: const ValueKey('stock-summary'),
      total: stats.total,
      optimal: stats.optimal,
      moyen: stats.moyen,
      faible: stats.faible,
      rupture: stats.rupture,
      onTap: () {
        // Naviguer vers la page stock complète
        Navigator.pushNamed(context, '/stock').then((_) {
          // Rafraîchir quand on revient
          if (mounted) {
            setState(() {
              _stockController = StockController();
              _stockController.initialize(mockStockItems);
            });
          }
        });
      },
    );
  }
}
