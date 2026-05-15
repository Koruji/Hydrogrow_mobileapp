import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/data/services/rgpd_service.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/components/app_scaffold.dart';
import 'package:hydrogrow/presentation/widgets/dialog_component.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RGPDPage extends StatefulWidget {
  const RGPDPage({super.key});

  @override
  State<RGPDPage> createState() => _RGPDPageState();
}

class _RGPDPageState extends State<RGPDPage> {
  final _service = RgpdService();
  bool _exportLoading = false;
  bool _downloadLoading = false;
  bool _deleteLoading = false;

  Future<void> _onExport() async {
    setState(() => _exportLoading = true);
    try {
      final data = await _service.exportData();
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Vos données'),
          content: SingleChildScrollView(
            child: Text(
              data.entries.map((e) => '${e.key}: ${e.value}').join('\n'),
              style: const TextStyle(fontSize: 13),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        ),
      );
    } catch (_) {
      if (!mounted) return;
      _showError('Impossible de récupérer vos données.');
    } finally {
      if (mounted) setState(() => _exportLoading = false);
    }
  }

  Future<void> _onDownload() async {
    setState(() => _downloadLoading = true);
    try {
      await _service.downloadData(format: 'json');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Export déclenché — vérifiez votre e-mail.')),
      );
    } catch (_) {
      if (!mounted) return;
      _showError('Impossible de lancer l\'export.');
    } finally {
      if (mounted) setState(() => _downloadLoading = false);
    }
  }

  void _onDeleteAccount() {
    showDialog(
      context: context,
      builder: (_) => AppDialog(
        title: 'Supprimer mon compte',
        content:
            'Cette action est irréversible. Toutes vos données seront définitivement supprimées. Continuer ?',
        firstAction: DialogAction(
          label: 'Annuler',
          onPressed: () => Navigator.pop(context),
        ),
        secondAction: DialogAction(
          label: 'Supprimer',
          onPressed: () async {
            Navigator.pop(context);
            setState(() => _deleteLoading = true);
            try {
              await _service.deleteAccount();
              if (!mounted) return;
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
            } catch (_) {
              if (!mounted) return;
              _showError('Impossible de supprimer le compte.');
            } finally {
              if (mounted) setState(() => _deleteLoading = false);
            }
          },
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.warning),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final colors = context.colors;

    return AppScaffold(
      currentRoute: '/account/rgpd',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: colors.icon),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  translate.account_page_rgpd_title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Conformément au RGPD, vous pouvez exercer vos droits à tout moment.',
              style: TextStyle(fontSize: 14, color: colors.textSecondary),
            ),
            const SizedBox(height: 24),

            _buildRightCard(
              colors: colors,
              icon: Icons.visibility_outlined,
              title: 'Droit d\'accès',
              description: 'Consultez l\'ensemble des données personnelles que nous détenons sur vous.',
              actionLabel: 'Voir mes données',
              loading: _exportLoading,
              onPressed: _onExport,
            ),
            const SizedBox(height: 16),

            _buildRightCard(
              colors: colors,
              icon: Icons.download_outlined,
              title: 'Droit à la portabilité',
              description: 'Téléchargez une copie complète de vos données au format JSON.',
              actionLabel: 'Exporter mes données',
              loading: _downloadLoading,
              onPressed: _onDownload,
            ),
            const SizedBox(height: 24),

            Divider(color: colors.divider),
            const SizedBox(height: 16),

            _buildRGPDSection(
              colors: colors,
              title: 'Minimisation des données',
              content: translate.account_page_rgpd_data_minimization
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              colors: colors,
              title: 'Limitation des finalités',
              content: translate.account_page_rgpd_purpose_limitation
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              colors: colors,
              title: 'Durée de conservation',
              content: translate.account_page_rgpd_retention
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              colors: colors,
              title: 'Sécurité',
              content: translate.account_page_rgpd_security
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
            ),
            const SizedBox(height: 20),
            _buildRGPDSection(
              colors: colors,
              title: 'Transparence',
              content: translate.account_page_rgpd_transparency
                  .split('\n')
                  .sublist(1)
                  .join('\n'),
            ),

            const SizedBox(height: 24),
            Divider(color: colors.divider),
            const SizedBox(height: 16),

            _buildDangerZone(colors),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRightCard({
    required AppColorsExtension colors,
    required IconData icon,
    required String title,
    required String description,
    required String actionLabel,
    required bool loading,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.menu.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: colors.menu, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: colors.textPrimary)),
                const SizedBox(height: 4),
                Text(description,
                    style:
                        TextStyle(fontSize: 13, color: colors.textSecondary)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: loading ? null : onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.menu,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                    child: loading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : Text(actionLabel,
                            style: const TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRGPDSection({
    required AppColorsExtension colors,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: colors.menu, width: 3)),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDangerZone(AppColorsExtension colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.delete_forever_outlined,
                color: AppColors.warning, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Droit à l\'effacement',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: colors.textPrimary)),
                const SizedBox(height: 4),
                Text(
                  'Supprimez définitivement votre compte et toutes vos données. Cette action est irréversible.',
                  style:
                      TextStyle(fontSize: 13, color: colors.textSecondary),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: _deleteLoading ? null : _onDeleteAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warning,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                    child: _deleteLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Supprimer mon compte',
                            style: TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
