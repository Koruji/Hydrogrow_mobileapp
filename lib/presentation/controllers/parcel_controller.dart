import 'package:hydrogrow/data/models/parcel.dart';

class ParcelController {
  List<Parcel> _allParcels = [];
  List<Parcel> _filteredParcels = [];

  String _selectedType = 'Tous';
  String _selectedStatus = 'Tous';

  List<Parcel> get filteredParcels => _filteredParcels;
  String get selectedType => _selectedType;
  String get selectedStatus => _selectedStatus;

  void initialize(List<Parcel> parcels) {
    _allParcels = parcels;
    _filteredParcels = parcels;
  }

  void applyFilters() {
    _filteredParcels = _allParcels.where((parcel) {
      final typeMatch =
          _selectedType == 'Tous' || parcel.type == _selectedType;
      final statusMatch =
          _selectedStatus == 'Tous' || parcel.status == _selectedStatus;
      return typeMatch && statusMatch;
    }).toList();
  }

  void setType(String type) {
    _selectedType = type;
    applyFilters();
  }

  void setStatus(String status) {
    _selectedStatus = status;
    applyFilters();
  }

  void resetFilters() {
    _selectedType = 'Tous';
    _selectedStatus = 'Tous';
    applyFilters();
  }

  List<String> getAvailableTypes() {
    final types = {'Tous', ..._allParcels.map((p) => p.type)};
    return types.toList()..sort();
  }

  ParcelStatistics getStatistics() {
    final active = _allParcels.where((p) => p.status == 'active').length;
    final planned = _allParcels.where((p) => p.status == 'planned').length;
    final inactive = _allParcels.where((p) => p.status == 'inactive').length;
    final totalPlants = _allParcels.fold<int>(0, (sum, p) => sum + p.nbPlant);

    return ParcelStatistics(
      total: _allParcels.length,
      active: active,
      planned: planned,
      inactive: inactive,
      totalPlants: totalPlants,
    );
  }

  Parcel? getParcelById(String id) {
    try {
      return _allParcels.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void addParcel(Parcel parcel) {
    _allParcels.add(parcel);
    applyFilters();
  }

  void updateParcel(String id, Parcel updated) {
    final index = _allParcels.indexWhere((p) => p.id == id);
    if (index != -1) {
      _allParcels[index] = updated;
      applyFilters();
    }
  }

  void deleteParcel(String id) {
    _allParcels.removeWhere((p) => p.id == id);
    applyFilters();
  }
}

class ParcelStatistics {
  final int total;
  final int active;
  final int planned;
  final int inactive;
  final int totalPlants;

  ParcelStatistics({
    required this.total,
    required this.active,
    required this.planned,
    required this.inactive,
    required this.totalPlants,
  });
}
