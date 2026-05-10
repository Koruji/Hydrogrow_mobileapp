import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/article.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';

class ArticleFormPage extends StatefulWidget {
  final Article? article;
  final String authorId;
  final String authorName;
  final void Function(Article article) onSave;

  const ArticleFormPage({
    super.key,
    this.article,
    required this.authorId,
    required this.authorName,
    required this.onSave,
  });

  @override
  State<ArticleFormPage> createState() => _ArticleFormPageState();
}

class _ArticleFormPageState extends State<ArticleFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _imageUrlController;
  late TextEditingController _tagsController;
  late String _selectedCategory;

  bool get _isEditing => widget.article != null;

  @override
  void initState() {
    super.initState();
    final a = widget.article;
    _titleController = TextEditingController(text: a?.title ?? '');
    _contentController = TextEditingController(text: a?.content ?? '');
    _imageUrlController = TextEditingController(text: a?.imageUrl ?? '');
    _tagsController = TextEditingController(
      text: a?.tags.join(', ') ?? '',
    );
    _selectedCategory = a?.category ?? articleCategories.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final tags = _tagsController.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final imageUrl = _imageUrlController.text.trim();

    final article = Article(
      id: widget.article?.id ?? 'art-${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      authorId: widget.authorId,
      authorName: widget.authorName,
      createdAt: widget.article?.createdAt ?? DateTime.now(),
      content: _contentController.text.trim(),
      category: _selectedCategory,
      tags: tags,
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
    );

    widget.onSave(article);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return AppScaffold(
      currentRoute: '/community',
      showDrawer: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context, translate),
              const SizedBox(height: 16),
              _buildSectionLabel(translate.article_form_category, context),
              const SizedBox(height: 8),
              _buildCategorySelector(context),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.article_form_title_label, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _titleController,
                hint: translate.article_form_title_hint,
                maxLines: 2,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? translate.article_form_title_required : null,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.article_form_content_label, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _contentController,
                hint: translate.article_form_content_hint,
                maxLines: 14,
                validator: (v) =>
                    (v == null || v.trim().length < 50)
                        ? translate.article_form_content_min
                        : null,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.article_form_tags_label, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _tagsController,
                hint: translate.article_form_tags_hint,
                maxLines: 1,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.article_form_image_label, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _imageUrlController,
                hint: translate.article_form_image_hint,
                maxLines: 1,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.menu,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isEditing ? translate.article_form_save : translate.article_form_publish,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, AppLocalizations translate) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios, size: 16, color: context.colors.textPrimary),
          const SizedBox(width: 4),
          Text(
            translate.article_form_back,
            style: TextStyle(
              fontSize: 14,
              color: context.colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label, BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: context.colors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required int maxLines,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final colors = context.colors;
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(fontSize: 14, color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: colors.textSecondary, fontSize: 13),
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.divider.withOpacity(0.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.divider.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.menu, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.warning),
        ),
      ),
    );
  }

  Widget _buildCategorySelector(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: articleCategories.map((cat) {
        final isSelected = cat == _selectedCategory;
        final tempArticle = Article(
          id: '',
          title: '',
          authorId: '',
          authorName: '',
          createdAt: DateTime.now(),
          content: '',
          category: cat,
        );
        final color = tempArticle.getCategoryColor();

        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? color : colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? color : colors.divider.withOpacity(0.4),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [BoxShadow(color: color.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 2))]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  tempArticle.getCategoryIcon(),
                  size: 14,
                  color: isSelected ? Colors.white : color,
                ),
                const SizedBox(width: 6),
                Text(
                  cat,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
