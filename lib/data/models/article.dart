import 'package:flutter/material.dart';

class Article {
  final String id;
  final String title;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final String content;
  final String category;
  final List<String> tags;
  final String? imageUrl;

  const Article({
    required this.id,
    required this.title,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.content,
    required this.category,
    this.tags = const [],
    this.imageUrl,
  });

  Article copyWith({
    String? title,
    String? content,
    String? category,
    List<String>? tags,
    String? imageUrl,
  }) {
    return Article(
      id: id,
      title: title ?? this.title,
      authorId: authorId,
      authorName: authorName,
      createdAt: createdAt,
      content: content ?? this.content,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Color getCategoryColor() {
    switch (category) {
      case 'Technique':
        return const Color(0xFF3B82F6);
      case 'Nutrition':
        return const Color(0xFF4BCE68);
      case 'Partage':
        return const Color(0xFF329D9C);
      case 'Question':
        return const Color(0xFFCE984B);
      case 'Innovation':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF329D9C);
    }
  }

  IconData getCategoryIcon() {
    switch (category) {
      case 'Technique':
        return Icons.build_outlined;
      case 'Nutrition':
        return Icons.science_outlined;
      case 'Partage':
        return Icons.share_outlined;
      case 'Question':
        return Icons.help_outline;
      case 'Innovation':
        return Icons.lightbulb_outline;
      default:
        return Icons.article_outlined;
    }
  }

  String getRelativeDate() {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    if (diff.inDays == 0) return "Aujourd'hui";
    if (diff.inDays == 1) return 'Hier';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays} jours';
    if (diff.inDays < 30) return 'Il y a ${(diff.inDays / 7).floor()} semaine(s)';
    if (diff.inDays < 365) return 'Il y a ${(diff.inDays / 30).floor()} mois';
    return 'Il y a ${(diff.inDays / 365).floor()} an(s)';
  }

  int getReadingTimeMinutes() {
    final words = content.split(' ').length;
    return (words / 200).ceil().clamp(1, 99);
  }
}

const List<String> articleCategories = [
  'Technique',
  'Nutrition',
  'Partage',
  'Question',
  'Innovation',
];
