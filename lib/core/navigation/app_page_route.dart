import 'package:flutter/material.dart';

class AppPageRoute<T> extends PageRouteBuilder<T> {
  AppPageRoute({required Widget page, RouteSettings? settings})
      : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            const curve = Curves.easeOutCubic;
            final slide = Tween(
              begin: const Offset(0.06, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve));
            final fade = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).chain(CurveTween(curve: curve));

            return FadeTransition(
              opacity: animation.drive(fade),
              child: SlideTransition(
                position: animation.drive(slide),
                child: child,
              ),
            );
          },
        );
}
