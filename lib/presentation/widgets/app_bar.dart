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

    return AppBar(
      backgroundColor: AppColors.menu,
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppColors.icon),
        onPressed: onMenuPressed ?? () {},
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/hydrogrow_logo.png'),
            height: 20,
            width: 20,
          ),
          SizedBox(width: 8),
          Text(
            translate.app_name,
            style: TextStyle(
              color: AppColors.titleText,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            isEditMode ? Icons.edit_off_outlined : Icons.edit_outlined,
            color: AppColors.icon,
          ),
          onPressed: onEditPressed ?? () {},
        ),
      ],
    );
  }

  //nécessaire pour définir la hauteur à implémenter à notre AppBar personnalisée
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
