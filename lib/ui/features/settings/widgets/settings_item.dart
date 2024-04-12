import 'package:habits24/app/app.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, this.onTap, this.widget, required this.name});

  final String name;
  final void Function()? onTap;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPadding.horizontal16,
        height: 50,
        decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            widget ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}