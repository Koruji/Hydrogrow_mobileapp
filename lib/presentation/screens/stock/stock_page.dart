import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/mock/stock_mock.dart';
import 'package:hydrogrow/data/models/stock.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/controllers/stock_controller.dart';
import 'package:hydrogrow/presentation/widgets/dialog_component.dart';
import 'package:hydrogrow/presentation/widgets/stock_filter.dart';
import 'package:hydrogrow/presentation/widgets/stock_card.dart';
import 'package:hydrogrow/presentation/widgets/stock_summary.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late StockController _stockController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeStock();
  }

  void _initializeStock() {
    _stockController = StockController();
    _stockController.initialize(mockStockItems);
  }

  void _onItemTap(Stock item) {
    // Optionnel: ouvrir un détail ou une modale
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} - ${item.quantity} ${item.unit}')),
    );
  }

  void _onEditPressed(Stock item) {
    // Implémentation de l'édition
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Éditer ${item.name}')));
  }

  void _onDeletePressed(Stock item) {
    // Confirmation avant suppression
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Supprimer l\'article',
        content: 'Êtes-vous sûr de vouloir supprimer ${item.name}?',
        firstAction: DialogAction(
          label: 'Annuler',
          onPressed: () => Navigator.pop(context),
        ),
        secondAction: DialogAction(
          label: 'Supprimer',
          onPressed: () {
            _stockController.deleteItem(item.id);
            Navigator.pop(context);
            setState(() {});
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${item.name} supprimé')));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final categories = _stockController.getAvailableCategories();
    final statistics = _stockController.getStatistics();
    final filteredItems = _stockController.filteredItems;

    return AppScaffold(
      currentRoute: '/stock',
      body: Container(
        color: context.colors.background,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre et résumé
                _buildHeader(filteredItems.length),
                const SizedBox(height: 20),

                // Cartes de résumé statistique
                StockSummaryRow(statistics: statistics),
                const SizedBox(height: 24),

                // Filtres
                StockFiltersWidget(
                  categories: categories,
                  selectedCategory: _stockController.selectedCategory,
                  selectedStatus: _stockController.selectedStatus,
                  onCategoryChanged: (category) {
                    _stockController.setCategory(category);
                    setState(() {});
                  },
                  onStatusChanged: (status) {
                    _stockController.setStatus(status);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),

                // Liste des articles
                _buildStockList(filteredItems),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int itemCount) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suivi des stocks',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors.textPrimary,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$itemCount article(s) en stock',
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
            ),
            if (_stockController.getStatistics().alertCount > 0)
              Chip(
                label: Text(
                  '${_stockController.getStatistics().alertCount} en alerte',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: AppColors.warning,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildStockList(List<Stock> items) {
    if (items.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: StockItemCard(
            item: item,
            onTap: () => _onItemTap(item),
            onEditPressed: () => _onEditPressed(item),
            onDeletePressed: () => _onDeletePressed(item),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48,
              color: colors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun article ne correspond à vos filtres',
              style: TextStyle(color: colors.textSecondary, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
