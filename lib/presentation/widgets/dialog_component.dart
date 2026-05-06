import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class DialogAction {
  final String label;
  final VoidCallback? onPressed;

  const DialogAction({required this.label, this.onPressed});
}

class AppDialog extends StatelessWidget {
  final String title;
  final String? content;
  final DialogAction firstAction;
  final DialogAction? secondAction;

  const AppDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.firstAction,
    this.secondAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content!),
      actions: [
        ElevatedButton(
          onPressed: firstAction.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shadowColor: AppColors.warning,
          ),
          child: Text(
            firstAction.label,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
        if (secondAction != null)
          ElevatedButton(
            onPressed: secondAction!.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.menu,
              shadowColor: AppColors.textPrimary,
            ),
            child: Text(
              secondAction!.label,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
      ],
    );
  }
}
