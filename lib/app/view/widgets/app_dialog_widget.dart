import 'package:flutter/material.dart';

class AppDialogWidget extends StatelessWidget {
  const AppDialogWidget({
    super.key,
    required this.title,
    required this.child,
    this.onTap, this.actions,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        title,
        style: theme.textTheme.titleLarge,
      ),
      content: child,
      actions: actions,
    );
  }
}
