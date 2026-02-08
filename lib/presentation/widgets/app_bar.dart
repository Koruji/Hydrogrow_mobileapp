import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  //quand on appel ce composant on peut définir les actions via ces 2 paramètres
  final VoidCallback? onMenuPressed;
  final VoidCallback? onEditPressed;

  const AppBarComponent({Key? key, this.onMenuPressed, this.onEditPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'HydroGrow',
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
          icon: Icon(Icons.edit_outlined, color: AppColors.icon),
          onPressed: onEditPressed ?? () {},
        ),
      ],
    );
  }

  //nécessaire pour définir la hauteur à implémenter à notre AppBar personnalisée
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
