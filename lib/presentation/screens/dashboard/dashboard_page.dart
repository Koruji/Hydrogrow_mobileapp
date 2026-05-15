import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/components/app_user_avatar.dart';
import 'package:hydrogrow/presentation/widgets/alert_message.dart';
import 'package:hydrogrow/presentation/widgets/dashboard_container.dart';
import 'package:hydrogrow/presentation/widgets/reordable_container_list.dart';
import 'package:hydrogrow/presentation/widgets/stock_summary_dashboard.dart';
import 'package:hydrogrow/presentation/widgets/parcel_summary_dashboard.dart';
import 'package:hydrogrow/presentation/widgets/community_summary_dashboard.dart';
import 'package:hydrogrow/presentation/screens/community/article_detail_page.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:hydrogrow/presentation/controllers/stock_controller.dart';
import 'package:hydrogrow/presentation/controllers/parcel_controller.dart';
import 'package:hydrogrow/presentation/controllers/article_controller.dart';
import 'package:hydrogrow/data/mock/stock_mock.dart';
import 'package:hydrogrow/data/mock/parcel_mock.dart';
import 'package:hydrogrow/data/mock/article_mock.dart';
import 'package:hydrogrow/services/weather_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isEditMode = false;
  WeatherData? _weather;
  bool _weatherLoading = true;

  late StockController _stockController;
  late ParcelController _parcelController;
  late ArticleController _articleController;

  @override
  void initState() {
    super.initState();
    _stockController = StockController();
    _stockController.initialize(mockStockItems);
    _parcelController = ParcelController();
    _parcelController.initialize(mockParcels);
    _articleController = ArticleController();
    _articleController.initialize(mockArticles);
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    final data = await WeatherService().fetch();
    if (mounted) {
      setState(() {
        _weather = data;
        _weatherLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final isPremium = authProvider.subscription != 'freemium' &&
        authProvider.subscription != 'free';
    final containersTitle = [
      'Stocks',
      'Parcelles',
      translate.dashboard_block_2_title,
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
          _buildGreetingSection(user?['username'] as String?, translate),
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
                if (title == 'Stocks') {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: _buildStockSummaryContainer(),
                  );
                } else if (title == 'Parcelles') {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: _buildParcelSummaryContainer(),
                  );
                } else if (title == translate.dashboard_block_2_title) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: _buildCommunitySummaryContainer(),
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

  Widget _buildGreetingSection(String? login, AppLocalizations translate) {
    final hour = DateTime.now().hour;
    final greeting = hour < 18 ? translate.dashboard_welcome : 'Bonsoir';
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.menu.withValues(alpha: 0.13),
            colors.background.withValues(alpha: 0.6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.menu.withValues(alpha: 0.30), width: 1),
      ),
      child: Row(
        children: [
          UserAvatar(),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(
                    color: colors.textPrimary.withValues(alpha: 0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  login ?? '',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          _buildWeatherChip(),
        ],
      ),
    );
  }

  Widget _buildWeatherChip() {
    final colors = context.colors;

    if (_weatherLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: colors.menu.withValues(alpha: 0.6),
        ),
      );
    }

    if (_weather == null) {
      return Icon(Icons.energy_savings_leaf_rounded, color: colors.menu, size: 30);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.menu.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.menu.withValues(alpha: 0.25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_weather!.emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 2),
          Text(
            '${_weather!.temperature.round()}°C',
            style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w700),
          ),
          Text(
            _weather!.description,
            style: TextStyle(color: colors.textPrimary.withValues(alpha: 0.55), fontSize: 10),
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

  Widget _buildCommunitySummaryContainer() {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final recentArticles = mockArticles.where((a) {
      final d = a.createdAt;
      final isToday = d.year == now.year && d.month == now.month && d.day == now.day;
      final isYesterday = d.year == yesterday.year && d.month == yesterday.month && d.day == yesterday.day;
      return isToday || isYesterday;
    }).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return CommunitySummaryWidget(
      key: const ValueKey('community-summary'),
      recentArticles: recentArticles,
      onTap: () {
        Navigator.pushNamed(context, '/community').then((_) {
          if (mounted) setState(() {});
        });
      },
      onArticleTap: (article) {
        final currentUserId = Provider.of<AuthProvider>(context, listen: false).username;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailPage(
              article: article,
              isOwner: article.authorId == currentUserId,
            ),
          ),
        );
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
