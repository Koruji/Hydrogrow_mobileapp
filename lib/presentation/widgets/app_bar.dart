import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onEditPressed;
  final bool isEditMode;

  const AppBarComponent({
    super.key,
    this.onMenuPressed,
    this.onEditPressed,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final colors = context.colors;

    return AppBar(
      backgroundColor: colors.menu,
      leading: IconButton(
        icon: Icon(Icons.menu, color: colors.titleText),
        onPressed: onMenuPressed ?? () {},
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('assets/images/hydrogrow_logo.png'),
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 8),
          Text(
            translate.app_name,
            style: TextStyle(
              color: colors.titleText,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        if (onEditPressed != null)
          IconButton(
            icon: Icon(
              isEditMode ? Icons.edit_off_outlined : Icons.edit_outlined,
              color: colors.titleText,
            ),
            onPressed: onEditPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
