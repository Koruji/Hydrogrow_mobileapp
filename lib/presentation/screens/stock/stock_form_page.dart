import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/stock.dart';
import 'package:hydrogrow/data/services/inventory_service.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';

class StockFormPage extends StatefulWidget {
  final Stock? item;

  const StockFormPage({super.key, this.item});

  @override
  State<StockFormPage> createState() => _StockFormPageState();
}

class _StockFormPageState extends State<StockFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = InventoryService();
  bool _isLoading = false;

  late final TextEditingController _nameCtrl;
  late final TextEditingController _quantityCtrl;
  late final TextEditingController _brandCtrl;
  late final TextEditingController _minThresholdCtrl;
  late final TextEditingController _costCtrl;
  late final TextEditingController _notesCtrl;
  String _category = 'substrate';
  String _unit = 'qty';

  static const _categories = [
    ('seed', 'Semences'),
    ('nutrient', 'Engrais / Nutriments'),
    ('ph_control', 'Correcteur pH'),
    ('substrate', 'Substrat'),
    ('equipment', 'Équipement'),
    ('other', 'Autre'),
  ];

  static const _units = [
    ('qty', 'Unité (qté)'),
    ('g', 'Grammes (g)'),
    ('kg', 'Kilogrammes (kg)'),
    ('ml', 'Millilitres (ml)'),
    ('l', 'Litres (l)'),
  ];

  bool get _isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _nameCtrl = TextEditingController(text: item?.name ?? '');
    _quantityCtrl = TextEditingController(text: item?.quantity.toString() ?? '');
    _brandCtrl = TextEditingController(text: item?.brand ?? '');
    _minThresholdCtrl = TextEditingController(text: item?.minThreshold.toString() ?? '1');
    _costCtrl = TextEditingController(
        text: item?.costPerUnit == 0 ? '' : item?.costPerUnit.toString() ?? '');
    _notesCtrl = TextEditingController(text: item?.notes ?? '');
    if (item != null && _categories.any((c) => c.$1 == item.category)) {
      _category = item.category;
    }
    if (item != null && _units.any((u) => u.$1 == item.unit)) {
      _unit = item.unit;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _brandCtrl.dispose();
    _minThresholdCtrl.dispose();
    _costCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final data = {
      'name': _nameCtrl.text.trim(),
      'category': _category,
      'quantity': int.tryParse(_quantityCtrl.text) ?? 0,
      'unit': _unit,
      if (_brandCtrl.text.trim().isNotEmpty) 'brand': _brandCtrl.text.trim(),
      'min_threshold': int.tryParse(_minThresholdCtrl.text) ?? 1,
      if (_costCtrl.text.trim().isNotEmpty)
        'cost_per_unit': double.tryParse(_costCtrl.text.trim()) ?? 0,
      if (_notesCtrl.text.trim().isNotEmpty) 'notes': _notesCtrl.text.trim(),
    };

    try {
      if (_isEdit) {
        await _service.update(widget.item!.id, data);
      } else {
        await _service.create(data);
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la sauvegarde')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return AppScaffold(
      currentRoute: '/stock',
      showDrawer: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context, translate),
              const SizedBox(height: 20),
              Text(
                _isEdit ? translate.stock_form_title_edit : translate.stock_form_title_create,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionLabel(translate.stock_form_field_name, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _nameCtrl,
                hint: translate.stock_form_field_name_hint,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? translate.stock_form_field_name_required
                    : null,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.stock_form_field_category, context),
              const SizedBox(height: 8),
              _buildCategorySelector(context),
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel(translate.stock_form_field_quantity, context),
                        const SizedBox(height: 8),
                        _buildTextField(
                          context: context,
                          controller: _quantityCtrl,
                          hint: '0',
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return translate.stock_form_field_quantity_required;
                            }
                            if (int.tryParse(v) == null) {
                              return translate.stock_form_field_quantity_invalid;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel(translate.stock_form_field_unit, context),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          context: context,
                          value: _unit,
                          items: _units,
                          onChanged: (v) => setState(() => _unit = v!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.stock_form_field_threshold, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _minThresholdCtrl,
                hint: '1',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v != null && v.isNotEmpty && int.tryParse(v) == null) {
                    return translate.stock_form_field_threshold_invalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel(translate.stock_form_field_brand, context),
                        const SizedBox(height: 8),
                        _buildTextField(
                          context: context,
                          controller: _brandCtrl,
                          hint: '',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel(translate.stock_form_field_price, context),
                        const SizedBox(height: 8),
                        _buildTextField(
                          context: context,
                          controller: _costCtrl,
                          hint: '0.00',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (v) {
                            if (v != null && v.isNotEmpty && double.tryParse(v) == null) {
                              return translate.stock_form_field_price_invalid;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.stock_form_field_notes, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _notesCtrl,
                hint: '',
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.menu,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          _isEdit ? translate.stock_form_save : translate.stock_form_create,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              const SizedBox(height: 20),
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
            translate.stock_form_back,
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
    int maxLines = 1,
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
          borderSide: BorderSide(color: colors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.divider),
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

  Widget _buildDropdown(
      {required BuildContext context,
      required String value,
      required List<(String, String)> items,
      required void Function(String?) onChanged}) {
    final colors = context.colors;
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: colors.surface,
      style: TextStyle(color: colors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colors.menu, width: 1.5),
        ),
      ),
      items: items
          .map((i) => DropdownMenuItem(value: i.$1, child: Text(i.$2, style: const TextStyle(fontSize: 13))))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildCategorySelector(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _categories.map((cat) {
        final isSelected = cat.$1 == _category;
        return GestureDetector(
          onTap: () => setState(() => _category = cat.$1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? colors.menu : colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? colors.menu : colors.divider,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [BoxShadow(color: colors.menu.withValues(alpha: 0.25), blurRadius: 8, offset: const Offset(0, 2))]
                  : null,
            ),
            child: Text(
              cat.$2,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : colors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
