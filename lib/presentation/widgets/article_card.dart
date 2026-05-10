import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/article.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_card.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final bool isOwner;
  final VoidCallback onTap;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const ArticleCard({
    super.key,
    required this.article,
    required this.isOwner,
    required this.onTap,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final translate = AppLocalizations.of(context)!;
    final categoryColor = article.getCategoryColor();

    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: categoryColor, width: 4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.imageUrl != null) _buildImage(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 12, 0),
                child: _buildTopRow(colors, categoryColor, translate),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: _buildTitle(colors),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                child: _buildPreview(colors),
              ),
              if (article.tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: _buildTags(colors),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                child: _buildFooter(colors, translate),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Image.network(
        article.imageUrl!,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildTopRow(AppColorsExtension colors, Color categoryColor, AppLocalizations translate) {
    return Row(
      children: [
        _buildCategoryBadge(categoryColor),
        const Spacer(),
        if (isOwner)
          SizedBox(
            width: 30,
            height: 30,
            child: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.more_vert, size: 18, color: colors.textSecondary),
              onSelected: (value) {
                if (value == 'edit') onEditPressed?.call();
                if (value == 'delete') onDeletePressed?.call();
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(translate.common_edit, style: const TextStyle(fontSize: 13)),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(translate.common_delete, style: const TextStyle(color: Colors.red, fontSize: 13)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryBadge(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(article.getCategoryIcon(), size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            article.category,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(AppColorsExtension colors) {
    return Text(
      article.title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPreview(AppColorsExtension colors) {
    final preview = article.content
        .replaceAll(RegExp(r'\*\*.*?\*\*'), '')
        .replaceAll(RegExp(r'\n+'), ' ')
        .trim();

    return Text(
      preview,
      style: TextStyle(fontSize: 13, color: colors.textSecondary, height: 1.5),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTags(AppColorsExtension colors) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: article.tags.take(4).map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '#$tag',
            style: TextStyle(fontSize: 11, color: colors.textSecondary),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooter(AppColorsExtension colors, AppLocalizations translate) {
    return Row(
      children: [
        _buildAuthorAvatar(),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.authorName,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textPrimary),
              ),
              Text(
                article.getRelativeDate(),
                style: TextStyle(fontSize: 11, color: colors.textSecondary),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Icon(Icons.schedule, size: 13, color: colors.textSecondary),
            const SizedBox(width: 4),
            Text(
              '${article.getReadingTimeMinutes()} ${translate.article_read_min}',
              style: TextStyle(fontSize: 11, color: colors.textSecondary),
            ),
          ],
        ),
        if (isOwner) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: colors.menu.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              translate.article_my_article,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: colors.menu),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAuthorAvatar() {
    final initial = article.authorName.isNotEmpty ? article.authorName[0].toUpperCase() : '?';
    final color = article.getCategoryColor();

    return CircleAvatar(
      radius: 16,
      backgroundColor: color.withValues(alpha: 0.15),
      child: Text(
        initial,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
