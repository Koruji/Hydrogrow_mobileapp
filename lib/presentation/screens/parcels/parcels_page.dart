import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/mock/parcel_mock.dart';
import 'package:hydrogrow/data/models/parcel.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/controllers/parcel_controller.dart';
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
  late ParcelController _parcelController;

  @override
  void initState() {
    super.initState();
    _parcelController = ParcelController();
    _parcelController.initialize(mockParcels);
  }

  void _onParcelTap(Parcel parcel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${parcel.name} — ${parcel.nbPlant} plantes'),
      ),
    );
  }

  void _onEditPressed(Parcel parcel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Éditer ${parcel.name}')),
    );
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
          onPressed: () {
            _parcelController.deleteParcel(parcel.id);
            Navigator.pop(context);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${parcel.name} supprimée')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final types = _parcelController.getAvailableTypes();
    final statistics = _parcelController.getStatistics();
    final filteredParcels = _parcelController.filteredParcels;

    return AppScaffold(
      currentRoute: '/parcels',
      body: Container(
        color: context.colors.background,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(filteredParcels.length, statistics),
                const SizedBox(height: 20),

                ParcelSummaryRow(statistics: statistics),
                const SizedBox(height: 24),

                ParcelFiltersWidget(
                  types: types,
                  selectedType: _parcelController.selectedType,
                  selectedStatus: _parcelController.selectedStatus,
                  onTypeChanged: (type) {
                    _parcelController.setType(type);
                    setState(() {});
                  },
                  onStatusChanged: (status) {
                    _parcelController.setStatus(status);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),

                _buildParcelList(filteredParcels),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int count, ParcelStatistics statistics) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gestion des parcelles',
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
              '$count parcelle(s) affichée(s)',
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
            ),
            if (statistics.inactive > 0)
              Chip(
                label: Text(
                  '${statistics.inactive} inactive(s)',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: AppColors.warning,
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
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ParcelItemCard(
            parcel: parcel,
            onTap: () => _onParcelTap(parcel),
            onEditPressed: () => _onEditPressed(parcel),
            onDeletePressed: () => _onDeletePressed(parcel),
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
              Icons.grass_outlined,
              size: 48,
              color: colors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune parcelle ne correspond à vos filtres',
              style: TextStyle(color: colors.textSecondary, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
