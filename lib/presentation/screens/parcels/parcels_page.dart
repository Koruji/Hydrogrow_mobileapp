import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/parcel.dart';
import 'package:hydrogrow/data/services/installation_service.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/controllers/parcel_controller.dart';
import 'package:hydrogrow/presentation/screens/parcels/parcel_form_page.dart';
import 'package:hydrogrow/presentation/widgets/dialog_component.dart';
import 'package:hydrogrow/presentation/widgets/parcel_card.dart';
import 'package:hydrogrow/presentation/widgets/parcel_filter.dart';
import 'package:hydrogrow/presentation/widgets/parcel_summary.dart';

class ParcelsPage extends StatefulWidget {
  const ParcelsPage({super.key});

  @override
  State<ParcelsPage> createState() => _ParcelsPageState();
}

class _ParcelsPageState extends State<ParcelsPage> {
  final _service = InstallationService();
  final _controller = ParcelController();
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadParcels();
  }

  Future<void> _loadParcels() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final parcels = await _service.getAll();
      _controller.initialize(parcels);
    } catch (_) {
      _error = 'Impossible de charger les parcelles';
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _openForm({Parcel? parcel}) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ParcelFormPage(parcel: parcel)),
    );
    if (saved == true) _loadParcels();
  }

  void _onDeletePressed(Parcel parcel) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: 'Supprimer la parcelle',
        content: 'Êtes-vous sûr de vouloir supprimer "${parcel.name}" ?',
        firstAction: DialogAction(
          label: 'Annuler',
          onPressed: () => Navigator.pop(context),
        ),
        secondAction: DialogAction(
          label: 'Supprimer',
          onPressed: () async {
            Navigator.pop(context);
            try {
              await _service.delete(parcel.id);
              _loadParcels();
            } catch (_) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Erreur lors de la suppression')),
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
      currentRoute: '/parcels',
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
            onPressed: _loadParcels,
            icon: const Icon(Icons.refresh),
            label: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppLocalizations translate) {
    final types = _controller.getAvailableTypes();
    final statistics = _controller.getStatistics();
    final filteredParcels = _controller.filteredParcels;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(filteredParcels.length, statistics, translate),
            const SizedBox(height: 20),
            ParcelSummaryRow(statistics: statistics),
            const SizedBox(height: 24),
            ParcelFiltersWidget(
              types: types,
              selectedType: _controller.selectedType,
              selectedStatus: _controller.selectedStatus,
              onTypeChanged: (type) {
                _controller.setType(type);
                setState(() {});
              },
              onStatusChanged: (status) {
                _controller.setStatus(status);
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            _buildParcelList(filteredParcels),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
      int count, ParcelStatistics statistics, AppLocalizations translate) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate.parcel_page_title,
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
              '$count ${translate.parcel_page_count_label}',
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
            ),
            if (statistics.inactive > 0)
              Chip(
                label: Text(
                  '${statistics.inactive} ${translate.parcel_page_inactive_label}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: context.colors.warning,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildParcelList(List<Parcel> parcels) {
    if (parcels.isEmpty) {
      return _buildEmptyState();
    }
    return Column(
      children: parcels.map((parcel) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ParcelItemCard(
            parcel: parcel,
            onTap: () {},
            onEditPressed: () => _openForm(parcel: parcel),
            onDeletePressed: () => _onDeletePressed(parcel),
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
            Icon(Icons.grass_outlined, size: 48, color: colors.textSecondary),
            const SizedBox(height: 16),
            Text(
              translate.parcel_page_empty,
              style: TextStyle(color: colors.textSecondary, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Créer une parcelle'),
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
