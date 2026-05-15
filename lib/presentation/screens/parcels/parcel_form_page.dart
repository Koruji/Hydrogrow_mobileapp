import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/parcel.dart';
import 'package:hydrogrow/data/services/installation_service.dart';

class ParcelFormPage extends StatefulWidget {
  final Parcel? parcel;

  const ParcelFormPage({super.key, this.parcel});

  @override
  State<ParcelFormPage> createState() => _ParcelFormPageState();
}

class _ParcelFormPageState extends State<ParcelFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = InstallationService();
  bool _isLoading = false;

  late final TextEditingController _nameCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _nbPlantCtrl;
  String _type = 'Hydroponie';
  String _status = 'planned';
  DateTime _commissioningDate = DateTime.now();

  static const _types = [
    'Hydroponie',
    'Aquaponie',
    'Serre',
    'Plein air',
    'Autre',
  ];

  static const _statuses = [
    ('planned', 'Planifiée'),
    ('setup', 'En installation'),
    ('active', 'Active'),
    ('maintenance', 'Maintenance'),
    ('retired', 'Retirée'),
  ];

  bool get _isEdit => widget.parcel != null;

  @override
  void initState() {
    super.initState();
    final p = widget.parcel;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _locationCtrl = TextEditingController(text: p?.location ?? '');
    _nbPlantCtrl = TextEditingController(text: p?.nbPlant.toString() ?? '');
    if (p != null) {
      _type = _types.contains(p.type) ? p.type : 'Autre';
      _status = p.status;
      _commissioningDate = p.commissioningDate;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    _nbPlantCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _commissioningDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _commissioningDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final data = {
      'name': _nameCtrl.text.trim(),
      'type': _type,
      'status': _status,
      'commissioning_date': _commissioningDate.toIso8601String(),
      if (_locationCtrl.text.trim().isNotEmpty)
        'location': _locationCtrl.text.trim(),
      if (_nbPlantCtrl.text.trim().isNotEmpty)
        'nb_plant': int.tryParse(_nbPlantCtrl.text.trim()) ?? 0,
    };

    try {
      if (_isEdit) {
        await _service.update(widget.parcel!.id, data);
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
          _isEdit ? 'Modifier la parcelle' : 'Nouvelle parcelle',
          style: TextStyle(
              color: colors.textPrimary, fontWeight: FontWeight.w700),
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

              // Type
              DropdownButtonFormField<String>(
                value: _type,
                decoration: inputDecoration.copyWith(labelText: 'Type'),
                dropdownColor: colors.surface,
                style: TextStyle(color: colors.textPrimary),
                items: _types
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 16),

              // Statut
              DropdownButtonFormField<String>(
                value: _status,
                decoration: inputDecoration.copyWith(labelText: 'Statut'),
                dropdownColor: colors.surface,
                style: TextStyle(color: colors.textPrimary),
                items: _statuses
                    .map((s) =>
                        DropdownMenuItem(value: s.$1, child: Text(s.$2)))
                    .toList(),
                onChanged: (v) => setState(() => _status = v!),
              ),
              const SizedBox(height: 16),

              // Localisation
              TextFormField(
                controller: _locationCtrl,
                style: TextStyle(color: colors.textPrimary),
                decoration:
                    inputDecoration.copyWith(labelText: 'Localisation'),
              ),
              const SizedBox(height: 16),

              // Nombre de plantes
              TextFormField(
                controller: _nbPlantCtrl,
                style: TextStyle(color: colors.textPrimary),
                decoration:
                    inputDecoration.copyWith(labelText: 'Nombre de plantes'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v != null && v.isNotEmpty && int.tryParse(v) == null) {
                    return 'Nombre entier';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date de mise en service
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(12),
                child: InputDecorator(
                  decoration:
                      inputDecoration.copyWith(labelText: 'Mise en service'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_commissioningDate.day.toString().padLeft(2, '0')}/${_commissioningDate.month.toString().padLeft(2, '0')}/${_commissioningDate.year}',
                        style: TextStyle(color: colors.textPrimary),
                      ),
                      Icon(Icons.calendar_today_outlined,
                          size: 18, color: colors.icon),
                    ],
                  ),
                ),
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
                          _isEdit ? 'Enregistrer' : 'Créer la parcelle',
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
