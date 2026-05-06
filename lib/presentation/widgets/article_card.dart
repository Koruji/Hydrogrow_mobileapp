import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/article.dart';
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
    final categoryColor = article.getCategoryColor();

    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(color: categoryColor, width: 4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.imageUrl != null) _buildImage(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 12, 0),
                child: _buildTopRow(context, categoryColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: _buildTitle(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                child: _buildPreview(),
              ),
              if (article.tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: _buildTags(categoryColor),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                child: _buildFooter(),
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

  Widget _buildTopRow(BuildContext context, Color categoryColor) {
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
              icon: Icon(Icons.more_vert, size: 18, color: AppColors.textSecondary),
              onSelected: (value) {
                if (value == 'edit') onEditPressed?.call();
                if (value == 'delete') onDeletePressed?.call();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Modifier', style: TextStyle(fontSize: 13)),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Supprimer',
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
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
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(article.getCategoryIcon(), size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            article.category,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      article.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPreview() {
    final preview = article.content
        .replaceAll(RegExp(r'\*\*.*?\*\*'), '')
        .replaceAll(RegExp(r'\n+'), ' ')
        .trim();

    return Text(
      preview,
      style: TextStyle(
        fontSize: 13,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTags(Color categoryColor) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: article.tags.take(4).map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '#$tag',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooter() {
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
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                article.getRelativeDate(),
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Icon(Icons.schedule, size: 13, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              '${article.getReadingTimeMinutes()} min',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
        if (isOwner) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.menu.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Mon article',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.menu,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAuthorAvatar() {
    final initial = article.authorName.isNotEmpty
        ? article.authorName[0].toUpperCase()
        : '?';
    final color = article.getCategoryColor();

    return CircleAvatar(
      radius: 16,
      backgroundColor: color.withOpacity(0.15),
      child: Text(
        initial,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
