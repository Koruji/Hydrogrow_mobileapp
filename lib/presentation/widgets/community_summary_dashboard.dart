import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/article.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class CommunitySummaryWidget extends StatelessWidget {
  final List<Article> recentArticles;
  final VoidCallback? onTap;
  final void Function(Article article)? onArticleTap;

  const CommunitySummaryWidget({
    super.key,
    required this.recentArticles,
    this.onTap,
    this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            if (recentArticles.isEmpty) _buildEmptyState(context),
            for (final a in recentArticles)
              _ArticleRow(article: a, onTap: () => onArticleTap?.call(a)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.colors;
    final translate = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(translate.community_summary_title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.textPrimary)),
            const SizedBox(height: 4),
            Text(translate.community_summary_subtitle,
                style: TextStyle(fontSize: 12, color: colors.textSecondary)),
          ],
        ),
        if (recentArticles.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: colors.menu, borderRadius: BorderRadius.circular(12)),
            child: Text('${recentArticles.length} ${translate.community_summary_new_label}',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = context.colors;
    final translate = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article_outlined, size: 20, color: colors.textSecondary),
          const SizedBox(width: 8),
          Text(translate.community_summary_empty,
              style: TextStyle(fontSize: 13, color: colors.textSecondary)),
        ],
      ),
    );
  }
}

class _ArticleRow extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const _ArticleRow({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = article.getCategoryColor();
    final tags = article.tags.take(3).map((t) => '#$t').join('  ');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.divider, width: 0.8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: color),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CategoryBadge(icon: article.getCategoryIcon(), label: article.category, color: color),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(article.getRelativeDate(),
                                    style: TextStyle(fontSize: 10, color: colors.textSecondary)),
                                const SizedBox(width: 4),
                                Icon(Icons.chevron_right, size: 14, color: colors.textSecondary),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 11, color: colors.textSecondary),
                            const SizedBox(width: 4),
                            Text(article.authorName,
                                style: TextStyle(fontSize: 11, color: colors.textSecondary)),
                            if (tags.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Text('·', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(tags,
                                    style: TextStyle(
                                        fontSize: 10, color: colors.textSecondary, fontStyle: FontStyle.italic),
                                    maxLines: 1, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _CategoryBadge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
