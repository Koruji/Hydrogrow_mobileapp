import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class SideBarComponent extends StatefulWidget {
  final String currentRoute;

  const SideBarComponent({Key? key, this.currentRoute = '/dashboard'})
      : super(key: key);

  @override
  State<SideBarComponent> createState() => _SideBarComponentState();
}

class _SideBarComponentState extends State<SideBarComponent> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final drawerBg = isDark ? colors.surface : colors.menu;

    return Drawer(
      backgroundColor: drawerBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 48, left: 16, bottom: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close,
                    color: isDark ? colors.textSecondary : Colors.white.withValues(alpha: 0.85),
                    size: 26),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          if (isDark) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Text('Menu',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: colors.textSecondary)),
            ),
          ],
          _buildMenuItem(context, isDark: isDark, icon: Icons.dashboard_outlined, title: 'Dashboard', route: '/dashboard',
              onTap: () { Navigator.pop(context); Navigator.pushReplacementNamed(context, '/dashboard'); }),
          _buildMenuItem(context, isDark: isDark, icon: Icons.inventory_2_outlined, title: 'Stock', route: '/stock',
              onTap: () { Navigator.pop(context); Navigator.pushReplacementNamed(context, '/stock'); }),
          _buildMenuItem(context, isDark: isDark, icon: Icons.people_outline, title: 'Communauté', route: '/community',
              onTap: () { Navigator.pop(context); Navigator.pushReplacementNamed(context, '/community'); }),
          _buildMenuItem(context, isDark: isDark, icon: Icons.grass_outlined, title: 'Mes parcelles', route: '/parcels',
              onTap: () { Navigator.pop(context); Navigator.pushReplacementNamed(context, '/parcels'); }),
          _buildMenuItem(context, isDark: isDark, icon: Icons.account_circle_outlined, title: 'Mon compte', route: '/account',
              onTap: () { Navigator.pop(context); Navigator.pushReplacementNamed(context, '/account'); }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required bool isDark,
    required IconData icon,
    required String title,
    required String route,
    required VoidCallback onTap,
  }) {
    final colors = context.colors;
    final isSelected = widget.currentRoute == route;

    // Light mode: white pill background for selected, transparent otherwise
    // Dark mode: teal tinted background for selected, transparent otherwise
    final itemBg = isSelected
        ? (isDark
            ? colors.menu.withValues(alpha: 0.18)
            : Colors.white.withValues(alpha: 0.15))
        : Colors.transparent;

    final iconBg = isSelected
        ? (isDark ? colors.menu : Colors.white.withValues(alpha: 0.22))
        : (isDark
            ? colors.textSecondary.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.12));

    // Toujours blanc sur fond teal (sélectionné) ou atténué sinon
    final iconColor = isSelected
        ? Colors.white
        : (isDark ? colors.textSecondary : Colors.white.withValues(alpha: 0.75));

    final textColor = isSelected
        ? (isDark ? colors.menu : Colors.white)
        : (isDark ? colors.textPrimary : Colors.white.withValues(alpha: 0.8));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: itemBg,
        borderRadius: BorderRadius.circular(12),
        border: isSelected && isDark
            ? Border.all(color: colors.menu.withValues(alpha: 0.35), width: 1)
            : null,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      ),
    );
  }
}
