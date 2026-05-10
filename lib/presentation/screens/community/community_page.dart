import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/mock/article_mock.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/data/models/article.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/controllers/article_controller.dart';
import 'package:hydrogrow/presentation/screens/community/article_detail_page.dart';
import 'package:hydrogrow/presentation/screens/community/article_form_page.dart';
import 'package:hydrogrow/presentation/widgets/article_card.dart';
import 'package:hydrogrow/presentation/widgets/dialog_component.dart';
import 'package:provider/provider.dart';
import 'package:hydrogrow/providers/auth_provider.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late ArticleController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ArticleController();
    _controller.initialize(mockArticles);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _currentUserId =>
      Provider.of<AuthProvider>(context, listen: false).login;

  bool _isOwner(Article article) => article.authorId == _currentUserId;

  void _openDetail(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArticleDetailPage(
          article: article,
          isOwner: _isOwner(article),
          onEditPressed: () => _openForm(article: article),
          onDeletePressed: () => _confirmDelete(article),
        ),
      ),
    );
  }

  void _openForm({Article? article}) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArticleFormPage(
          article: article,
          authorId: auth.login,
          authorName: auth.login,
          onSave: (saved) {
            if (article != null) {
              _controller.update(article.id, saved);
            } else {
              _controller.add(saved);
            }
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  article != null
                      ? 'Article modifié avec succès'
                      : 'Article publié avec succès',
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _confirmDelete(Article article) {
    showDialog(
      context: context,
      builder: (_) => AppDialog(
        title: 'Supprimer l\'article',
        content: 'Êtes-vous sûr de vouloir supprimer "${article.title}" ? Cette action est irréversible.',
        firstAction: DialogAction(
          label: 'Annuler',
          onPressed: () => Navigator.pop(context),
        ),
        secondAction: DialogAction(
          label: 'Supprimer',
          onPressed: () {
            _controller.delete(article.id);
            Navigator.pop(context);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Article supprimé')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final currentUserId = _currentUserId;
    final stats = _controller.getStatistics(currentUserId);
    final articles = _controller.filteredArticles;

    return AppScaffold(
      currentRoute: '/community',
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        backgroundColor: context.colors.menu,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit_outlined),
      ),
      body: Container(
        color: context.colors.background,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(translate),
                const SizedBox(height: 20),
                _buildStatsRow(stats, translate),
                const SizedBox(height: 20),
                _buildSearchBar(translate),
                const SizedBox(height: 12),
                _buildCategoryFilter(translate),
                const SizedBox(height: 20),
                _buildArticleCount(articles.length, translate),
                const SizedBox(height: 12),
                _buildArticleList(articles, currentUserId),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations translate) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate.community_page_title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors.textPrimary,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          translate.community_page_subtitle,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(ArticleStatistics stats, AppLocalizations translate) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.article_outlined,
            label: translate.community_stat_articles,
            value: stats.total.toString(),
            color: context.colors.menu,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.person_outline,
            label: translate.community_stat_mine,
            value: stats.mine.toString(),
            color: const Color(0xFF8B5CF6),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.category_outlined,
            label: translate.community_stat_categories,
            value: stats.categoriesCount.toString(),
            color: const Color(0xFFCE984B),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(AppLocalizations translate) {
    final colors = context.colors;
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        _controller.setSearchQuery(value);
        setState(() {});
      },
      style: TextStyle(fontSize: 14, color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: translate.community_search_hint,
        hintStyle: TextStyle(color: colors.textSecondary, fontSize: 13),
        prefixIcon: Icon(Icons.search, color: colors.textSecondary, size: 20),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, size: 18, color: colors.textSecondary),
                onPressed: () {
                  _searchController.clear();
                  _controller.setSearchQuery('');
                  setState(() {});
                },
              )
            : null,
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.divider.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.divider.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.menu, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(AppLocalizations translate) {
    final categories = ['Toutes', ...articleCategories];
    final colors = context.colors;

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((cat) {
          final isSelected = _controller.selectedCategory == cat;
          Color color = colors.menu;
          if (cat != 'Toutes') {
            final dummy = Article(
              id: '',
              title: '',
              authorId: '',
              authorName: '',
              createdAt: DateTime.now(),
              content: '',
              category: cat,
            );
            color = dummy.getCategoryColor();
          }

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                _controller.setCategory(cat);
                setState(() {});
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? color : colors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? color : colors.divider.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  cat == 'Toutes' ? translate.community_filter_all : cat,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.white : colors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildArticleCount(int count, AppLocalizations translate) {
    return Text(
      '$count ${translate.community_articles_count_label}',
      style: TextStyle(color: context.colors.textSecondary, fontSize: 13),
    );
  }

  Widget _buildArticleList(List<Article> articles, String currentUserId) {
    if (articles.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: articles.map((article) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: ArticleCard(
            article: article,
            isOwner: article.authorId == currentUserId,
            onTap: () => _openDetail(article),
            onEditPressed: () => _openForm(article: article),
            onDeletePressed: () => _confirmDelete(article),
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
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.article_outlined, size: 52, color: colors.textSecondary),
            const SizedBox(height: 16),
            Text(
              translate.community_empty,
              style: TextStyle(color: colors.textSecondary, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                _searchController.clear();
                _controller.resetFilters();
                setState(() {});
              },
              child: Text(translate.community_reset_filters),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: context.colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
