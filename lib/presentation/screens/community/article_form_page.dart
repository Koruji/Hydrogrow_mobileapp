import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/article.dart';
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
              _buildBackButton(context),
              const SizedBox(height: 16),
              _buildSectionLabel('Catégorie'),
              const SizedBox(height: 8),
              _buildCategorySelector(),
              const SizedBox(height: 20),

              _buildSectionLabel('Titre *'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _titleController,
                hint: 'Donnez un titre accrocheur à votre article',
                maxLines: 2,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Le titre est requis' : null,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('Contenu *'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _contentController,
                hint: 'Partagez votre expérience, vos conseils, vos questions...',
                maxLines: 14,
                validator: (v) =>
                    (v == null || v.trim().length < 50)
                        ? 'Le contenu doit faire au moins 50 caractères'
                        : null,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('Tags (séparés par des virgules)'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _tagsController,
                hint: 'ex: hydroponie, pH, débutant',
                maxLines: 1,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('Image (URL, optionnel)'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _imageUrlController,
                hint: 'https://...',
                maxLines: 1,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.menu,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isEditing ? 'Enregistrer les modifications' : 'Publier l\'article',
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

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios, size: 16, color: AppColors.textPrimary),
          const SizedBox(width: 4),
          Text(
            'Communauté',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required int maxLines,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider.withOpacity(0.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.menu, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.warning),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
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
              color: isSelected ? color : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? color : AppColors.divider.withOpacity(0.4),
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
                    color: isSelected ? Colors.white : AppColors.textPrimary,
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
