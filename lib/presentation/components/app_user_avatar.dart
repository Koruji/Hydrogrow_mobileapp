import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final avatarUrl = authProvider.avatarUrl;
    final avatarShape = authProvider.avatarShape;
    final isCircle = avatarShape == 'circle';

    if (avatarUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(isCircle ? 60 : 8),
        child: Image.asset(
          avatarUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallback(context),
        ),
      );
    }

    return _buildFallback(context);
  }

  Widget _buildFallback(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: context.colors.menu,
      child: const Icon(Icons.person, size: 30, color: Colors.white),
    );
  }
}
