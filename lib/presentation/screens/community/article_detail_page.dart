import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/article.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  final bool isOwner;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const ArticleDetailPage({
    super.key,
    required this.article,
    required this.isOwner,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final categoryColor = article.getCategoryColor();

    return Scaffold(
      backgroundColor: context.colors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, categoryColor, translate),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryBadge(categoryColor),
                  const SizedBox(height: 16),
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: context.colors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAuthorRow(context, translate),
                  const SizedBox(height: 20),
                  Divider(color: context.colors.divider),
                  const SizedBox(height: 20),
                  _buildContent(),
                  if (article.tags.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildTags(categoryColor, context, translate),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, Color categoryColor, AppLocalizations translate) {
    return SliverAppBar(
      expandedHeight: article.imageUrl != null ? 220 : 0,
      pinned: true,
      backgroundColor: context.colors.menu,
      foregroundColor: Colors.white,
      actions: isOwner
          ? [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == 'edit') {
                    Navigator.pop(context);
                    onEditPressed?.call();
                  }
                  if (value == 'delete') {
                    Navigator.pop(context);
                    onDeletePressed?.call();
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text(translate.article_action_edit),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      translate.article_action_delete,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ]
          : null,
      flexibleSpace: article.imageUrl != null
          ? FlexibleSpaceBar(
              background: Image.network(
                article.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: categoryColor.withOpacity(0.2)),
              ),
            )
          : null,
    );
  }

  Widget _buildCategoryBadge(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(article.getCategoryIcon(), size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            article.category,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorRow(BuildContext context, AppLocalizations translate) {
    final colors = context.colors;
    final categoryColor = article.getCategoryColor();
    final initial = article.authorName.isNotEmpty
        ? article.authorName[0].toUpperCase()
        : '?';

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: categoryColor.withOpacity(0.15),
          child: Text(
            initial,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: categoryColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  article.authorName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                if (isOwner) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: colors.menu.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      translate.article_detail_you,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: colors.menu,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Row(
              children: [
                Text(
                  article.getRelativeDate(),
                  style: TextStyle(fontSize: 12, color: colors.textSecondary),
                ),
                const SizedBox(width: 12),
                Icon(Icons.schedule, size: 12, color: colors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  '${article.getReadingTimeMinutes()} ${translate.article_detail_read_label}',
                  style: TextStyle(fontSize: 12, color: colors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return _MarkdownText(content: article.content);
  }

  Widget _buildTags(Color categoryColor, BuildContext context, AppLocalizations translate) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate.article_detail_tags,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: article.tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: categoryColor.withOpacity(0.3)),
              ),
              child: Text(
                '#$tag',
                style: TextStyle(
                  fontSize: 13,
                  color: categoryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MarkdownText extends StatelessWidget {
  final String content;

  const _MarkdownText({required this.content});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lines = content.split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.startsWith('**') && line.endsWith('**')) {
          return Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              line.replaceAll('**', ''),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          );
        }
        if (line.startsWith('✅') || line.startsWith('❌')) {
          return Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              line,
              style: TextStyle(
                fontSize: 14,
                color: colors.textPrimary,
                height: 1.6,
              ),
            ),
          );
        }
        if (line.trim().isEmpty) {
          return const SizedBox(height: 10);
        }
        return Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            line,
            style: TextStyle(
              fontSize: 15,
              color: colors.textPrimary,
              height: 1.7,
            ),
          ),
        );
      }).toList(),
    );
  }
}
