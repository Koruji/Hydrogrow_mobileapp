import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/stock.dart';
import 'package:hydrogrow/data/services/inventory_service.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/controllers/stock_controller.dart';
import 'package:hydrogrow/presentation/screens/stock/stock_form_page.dart';
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
  final _service = InventoryService();
  final _controller = StockController();
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = await _service.getAll();
      _controller.initialize(items);
    } catch (_) {
      _error = 'Impossible de charger le stock';
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _openForm({Stock? item}) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => StockFormPage(item: item)),
    );
    if (saved == true) _loadItems();
  }

  void _onDeletePressed(Stock item) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Supprimer l\'article',
        content: 'Êtes-vous sûr de vouloir supprimer ${item.name} ?',
        firstAction: DialogAction(
          label: 'Annuler',
          onPressed: () => Navigator.pop(context),
        ),
        secondAction: DialogAction(
          label: 'Supprimer',
          onPressed: () async {
            Navigator.pop(context);
            try {
              await _service.delete(item.id);
              _loadItems();
            } catch (_) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Erreur lors de la suppression')),
                );
              }
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return AppScaffold(
      currentRoute: '/stock',
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        backgroundColor: context.colors.menu,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: context.colors.background,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? _buildError()
                : _buildContent(translate),
      ),
    );
  }

  Widget _buildError() {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off_outlined, size: 48, color: colors.textSecondary),
          const SizedBox(height: 16),
          Text(_error!, style: TextStyle(color: colors.textSecondary)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _loadItems,
            icon: const Icon(Icons.refresh),
            label: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppLocalizations translate) {
    final categories = _controller.getAvailableCategories();
    final statistics = _controller.getStatistics();
    final filteredItems = _controller.filteredItems;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(filteredItems.length, translate),
            const SizedBox(height: 20),
            StockSummaryRow(statistics: statistics),
            const SizedBox(height: 24),
            StockFiltersWidget(
              categories: categories,
              selectedCategory: _controller.selectedCategory,
              selectedStatus: _controller.selectedStatus,
              onCategoryChanged: (category) {
                _controller.setCategory(category);
                setState(() {});
              },
              onStatusChanged: (status) {
                _controller.setStatus(status);
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            _buildStockList(filteredItems),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int itemCount, AppLocalizations translate) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate.stock_page_title,
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
              '$itemCount ${translate.stock_page_items_label}',
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
            ),
            if (_controller.getStatistics().alertCount > 0)
              Chip(
                label: Text(
                  '${_controller.getStatistics().alertCount} ${translate.stock_page_alert_label}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: context.colors.warning,
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
          padding: const EdgeInsets.only(bottom: 12),
          child: StockItemCard(
            item: item,
            onTap: () {},
            onEditPressed: () => _openForm(item: item),
            onDeletePressed: () => _onDeletePressed(item),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    final colors = context.colors;
    final translate = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(Icons.inbox_outlined, size: 48, color: colors.textSecondary),
            const SizedBox(height: 16),
            Text(
              translate.stock_page_empty,
              style: TextStyle(color: colors.textSecondary, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un article'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.menu,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
