import 'package:flutter/material.dart';
import 'package:hydrogrow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final avatarUrl = authProvider.avatarUrl;
    final avatarShape = authProvider.avatarShape;

    if (avatarUrl.isNotEmpty) {
      if (avatarShape == 'circle') {
        return CircleAvatar(radius: 30, backgroundImage: AssetImage(avatarUrl));
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(avatarShape == 'circle' ? 10 : 0),
          child: Image.asset(
            avatarUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, size: 30),
      );
    }
  }
}
