import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/stock.dart';
import 'package:hydrogrow/data/services/inventory_service.dart';

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
  late final TextEditingController _unitCtrl;
  late final TextEditingController _brandCtrl;
  late final TextEditingController _minThresholdCtrl;
  late final TextEditingController _costCtrl;
  late final TextEditingController _notesCtrl;
  String _category = 'Substrat';

  static const _categories = [
    'Engrais',
    'Substrat',
    'Semences',
    'Outillage',
    'Phytosanitaire',
    'Équipement',
    'Autre',
  ];

  bool get _isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _nameCtrl = TextEditingController(text: item?.name ?? '');
    _quantityCtrl = TextEditingController(text: item?.quantity.toString() ?? '');
    _unitCtrl = TextEditingController(text: item?.unit ?? 'unité');
    _brandCtrl = TextEditingController(text: item?.brand ?? '');
    _minThresholdCtrl = TextEditingController(
        text: item?.minThreshold.toString() ?? '1');
    _costCtrl = TextEditingController(
        text: item?.costPerUnit == 0 ? '' : item?.costPerUnit.toString() ?? '');
    _notesCtrl = TextEditingController(text: item?.notes ?? '');
    if (item != null && _categories.contains(item.category)) {
      _category = item.category;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _quantityCtrl.dispose();
    _unitCtrl.dispose();
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
      'unit': _unitCtrl.text.trim().isEmpty ? 'unité' : _unitCtrl.text.trim(),
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
    final colors = context.colors;

    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.menu, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.warning),
      ),
      filled: true,
      fillColor: colors.surface,
      labelStyle: TextStyle(color: colors.textSecondary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          _isEdit ? 'Modifier l\'article' : 'Nouvel article',
          style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700),
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nom
              TextFormField(
                controller: _nameCtrl,
                style: TextStyle(color: colors.textPrimary),
                decoration: inputDecoration.copyWith(labelText: 'Nom *'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 16),

              // Catégorie
              DropdownButtonFormField<String>(
                value: _category,
                decoration: inputDecoration.copyWith(labelText: 'Catégorie *'),
                dropdownColor: colors.surface,
                style: TextStyle(color: colors.textPrimary),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              const SizedBox(height: 16),

              // Quantité + Unité
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _quantityCtrl,
                      style: TextStyle(color: colors.textPrimary),
                      decoration: inputDecoration.copyWith(labelText: 'Quantité *'),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Obligatoire';
                        if (int.tryParse(v) == null) return 'Nombre entier';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _unitCtrl,
                      style: TextStyle(color: colors.textPrimary),
                      decoration: inputDecoration.copyWith(labelText: 'Unité'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Seuil minimum
              TextFormField(
                controller: _minThresholdCtrl,
                style: TextStyle(color: colors.textPrimary),
                decoration:
                    inputDecoration.copyWith(labelText: 'Seuil d\'alerte'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v != null && v.isNotEmpty && int.tryParse(v) == null) {
                    return 'Nombre entier';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Marque + Prix
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _brandCtrl,
                      style: TextStyle(color: colors.textPrimary),
                      decoration: inputDecoration.copyWith(labelText: 'Marque'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _costCtrl,
                      style: TextStyle(color: colors.textPrimary),
                      decoration: inputDecoration.copyWith(labelText: 'Prix unitaire (€)'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) {
                        if (v != null && v.isNotEmpty && double.tryParse(v) == null) {
                          return 'Nombre invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesCtrl,
                style: TextStyle(color: colors.textPrimary),
                decoration: inputDecoration.copyWith(labelText: 'Notes'),
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              // Bouton submit
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.menu,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          _isEdit ? 'Enregistrer' : 'Ajouter au stock',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
