import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class SideBarComponent extends StatefulWidget {
  //pour récupérer la route actuelle et mettre en surbrillance l'item correspondant dans le menu
  final String currentRoute;

  const SideBarComponent({
    Key? key,
    this.currentRoute = '/dashboard',
  }) : super(key: key);

  @override
  State<SideBarComponent> createState() => _SideBarComponentState();
}

class _SideBarComponentState extends State<SideBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.menu,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Bouton de fermeture
          Container(
            padding: EdgeInsets.only(top: 40, left: 16, bottom: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close, color: AppColors.icon, size: 28),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Menu Items
          _buildMenuItem(
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            route: '/dashboard',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),

          _buildMenuItem(
            icon: Icons.inventory_2_outlined,
            title: 'Stock',
            route: '/stock',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/stock');
            },
          ),

          _buildMenuItem(
            icon: Icons.credit_card,
            title: 'Suivi Dépense',
            route: '/expenses',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/expenses');
            },
          ),

          _buildMenuItem(
            icon: Icons.people_outline,
            title: 'Communauté',
            route: '/community',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/community');
            },
          ),

          _buildMenuItem(
            icon: Icons.grass_outlined,
            title: 'Mes parcelles',
            route: '/parcels',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/parcels');
            },
          ),

          _buildMenuItem(
            icon: Icons.account_circle_outlined,
            title: 'Mon compte',
            route: '/account',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/account');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String route,
    required VoidCallback onTap,
  }) {
    bool isSelected = widget.currentRoute == route;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.background : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.textPrimary: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.textPrimary : AppColors.titleText,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}