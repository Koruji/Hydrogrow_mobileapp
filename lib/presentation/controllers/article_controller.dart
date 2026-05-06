import 'package:hydrogrow/data/models/article.dart';

class ArticleController {
  List<Article> _allArticles = [];
  List<Article> _filteredArticles = [];

  String _selectedCategory = 'Toutes';
  String _searchQuery = '';

  List<Article> get filteredArticles => _filteredArticles;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void initialize(List<Article> articles) {
    _allArticles = List.from(articles);
    _filteredArticles = List.from(articles);
  }

  void applyFilters() {
    _filteredArticles = _allArticles.where((article) {
      final categoryMatch =
          _selectedCategory == 'Toutes' || article.category == _selectedCategory;
      final query = _searchQuery.toLowerCase();
      final searchMatch = query.isEmpty ||
          article.title.toLowerCase().contains(query) ||
          article.authorName.toLowerCase().contains(query) ||
          article.tags.any((t) => t.toLowerCase().contains(query));
      return categoryMatch && searchMatch;
    }).toList();

    _filteredArticles.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void setCategory(String category) {
    _selectedCategory = category;
    applyFilters();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    applyFilters();
  }

  void resetFilters() {
    _selectedCategory = 'Toutes';
    _searchQuery = '';
    applyFilters();
  }

  ArticleStatistics getStatistics(String currentUserId) {
    final myCount = _allArticles.where((a) => a.authorId == currentUserId).length;
    final categories = _allArticles.map((a) => a.category).toSet();
    return ArticleStatistics(
      total: _allArticles.length,
      mine: myCount,
      categoriesCount: categories.length,
    );
  }

  Article? getById(String id) {
    try {
      return _allArticles.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  void add(Article article) {
    _allArticles.insert(0, article);
    applyFilters();
  }

  void update(String id, Article updated) {
    final index = _allArticles.indexWhere((a) => a.id == id);
    if (index != -1) {
      _allArticles[index] = updated;
      applyFilters();
    }
  }

  void delete(String id) {
    _allArticles.removeWhere((a) => a.id == id);
    applyFilters();
  }
}

class ArticleStatistics {
  final int total;
  final int mine;
  final int categoriesCount;

  const ArticleStatistics({
    required this.total,
    required this.mine,
    required this.categoriesCount,
  });
}
