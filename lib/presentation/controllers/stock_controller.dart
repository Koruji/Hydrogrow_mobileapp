import 'package:hydrogrow/data/models/stock.dart';

class StockController {
  List<Stock> _allItems = [];
  List<Stock> _filteredItems = [];

  String _selectedCategory = 'Tous';
  String _selectedStatus = 'Tous';

  // Getters
  List<Stock> get filteredItems => _filteredItems;
  String get selectedCategory => _selectedCategory;
  String get selectedStatus => _selectedStatus;

  /// Initialise le contrôleur avec une liste d'articles
  void initialize(List<Stock> items) {
    _allItems = items;
    _filteredItems = items;
  }

  /// Applique les filtres actuels
  void applyFilters() {
    _filteredItems = _allItems.where((item) {
      final categoryMatch =
          _selectedCategory == 'Tous' || item.category == _selectedCategory;
      final statusMatch =
          _selectedStatus == 'Tous' || item.getStatus() == _selectedStatus;
      return categoryMatch && statusMatch;
    }).toList();
  }

  /// Change la catégorie sélectionnée
  void setCategory(String category) {
    _selectedCategory = category;
    applyFilters();
  }

  /// Change le statut sélectionné
  void setStatus(String status) {
    _selectedStatus = status;
    applyFilters();
  }

  /// Réinitialise tous les filtres
  void resetFilters() {
    _selectedCategory = 'Tous';
    _selectedStatus = 'Tous';
    applyFilters();
  }

  /// Retourne la liste unique des catégories disponibles
  List<String> getAvailableCategories() {
    final categories = {'Tous', ..._allItems.map((e) => e.category)};
    return categories.toList()..sort();
  }

  /// Retourne les statistiques du stock
  StockStatistics getStatistics() {
    final optimal = _allItems
        .where((item) => item.getStatus() == 'optimal')
        .length;
    final moyen = _allItems.where((item) => item.getStatus() == 'moyen').length;
    final faible = _allItems
        .where((item) => item.getStatus() == 'faible')
        .length;
    final rupture = _allItems
        .where((item) => item.getStatus() == 'rupture')
        .length;

    return StockStatistics(
      total: _allItems.length,
      optimal: optimal,
      moyen: moyen,
      faible: faible,
      rupture: rupture,
      totalValue: _allItems.fold(
        0.0,
        (sum, item) => sum + item.getTotalValue(),
      ),
    );
  }

  /// Recherche un article par ID
  Stock? getItemById(String id) {
    try {
      return _allItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Ajoute un nouvel article
  void addItem(Stock item) {
    _allItems.add(item);
    applyFilters();
  }

  /// Met à jour un article existant
  void updateItem(String id, Stock updatedItem) {
    final index = _allItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      _allItems[index] = updatedItem;
      applyFilters();
    }
  }

  /// Supprime un article
  void deleteItem(String id) {
    _allItems.removeWhere((item) => item.id == id);
    applyFilters();
  }

  /// Augmente la quantité d'un article
  void increaseQuantity(String id, int amount) {
    final item = getItemById(id);
    if (item != null) {
      updateItem(id, item.copyWith(quantity: item.quantity + amount));
    }
  }

  /// Diminue la quantité d'un article
  void decreaseQuantity(String id, int amount) {
    final item = getItemById(id);
    if (item != null) {
      final newQuantity = (item.quantity - amount)
          .clamp(0, double.infinity)
          .toInt();
      updateItem(id, item.copyWith(quantity: newQuantity));
    }
  }
}

/// Classe pour les statistiques du stock
class StockStatistics {
  final int total;
  final int optimal;
  final int moyen;
  final int faible;
  final int rupture;
  final double totalValue;

  StockStatistics({
    required this.total,
    required this.optimal,
    required this.moyen,
    required this.faible,
    required this.rupture,
    required this.totalValue,
  });

  /// Compte les articles en alerte (faible ou rupture)
  int get alertCount => faible + rupture;

  /// Pourcentage d'articles en statut optimal
  double get optimalPercentage => total > 0 ? (optimal / total) * 100 : 0;
}
