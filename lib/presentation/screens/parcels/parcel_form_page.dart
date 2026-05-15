import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/models/parcel.dart';
import 'package:hydrogrow/data/services/installation_service.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';

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
    final translate = AppLocalizations.of(context)!;
    final colors = context.colors;

    return AppScaffold(
      currentRoute: '/parcels',
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
                _isEdit ? translate.parcel_form_title_edit : translate.parcel_form_title_create,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionLabel(translate.parcel_form_field_name, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _nameCtrl,
                hint: translate.parcel_form_field_name_hint,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? translate.parcel_form_field_name_required
                    : null,
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.parcel_form_field_type, context),
              const SizedBox(height: 8),
              _buildTypeSelector(context),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.parcel_form_field_status, context),
              const SizedBox(height: 8),
              _buildStatusSelector(context),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.parcel_form_field_location, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _locationCtrl,
                hint: '',
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.parcel_form_field_plants, context),
              const SizedBox(height: 8),
              _buildTextField(
                context: context,
                controller: _nbPlantCtrl,
                hint: '0',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v != null && v.isNotEmpty && int.tryParse(v) == null) {
                    return translate.parcel_form_field_plants_invalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildSectionLabel(translate.parcel_form_field_date, context),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.divider),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_commissioningDate.day.toString().padLeft(2, '0')}/${_commissioningDate.month.toString().padLeft(2, '0')}/${_commissioningDate.year}',
                        style: TextStyle(fontSize: 14, color: colors.textPrimary),
                      ),
                      Icon(Icons.calendar_today_outlined, size: 18, color: colors.icon),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.menu,
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
                          _isEdit ? translate.parcel_form_save : translate.parcel_form_create,
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
            translate.parcel_form_back,
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

  Widget _buildTypeSelector(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _types.map((type) {
        final isSelected = type == _type;
        return GestureDetector(
          onTap: () => setState(() => _type = type),
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
              type,
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

  Widget _buildStatusSelector(BuildContext context) {
    final colors = context.colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _statuses.map((s) {
        final isSelected = s.$1 == _status;
        return GestureDetector(
          onTap: () => setState(() => _status = s.$1),
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
              s.$2,
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
