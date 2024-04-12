import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';

class AppDropdownButtonWidget<T> extends StatelessWidget {
  final T? value;
  final Function(T? value) onChanged;
  final List<DropdownMenuItem<T>> items;

  const AppDropdownButtonWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButton<T>(
      //isExpanded: true,
      iconSize: 24,
      alignment: Alignment.bottomLeft,
      value: value,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: AppColors.orange,
      ),
      elevation: 16,
      style: theme.textTheme.titleMedium,
      dropdownColor: AppColors.grey,
      underline: Container(
        width: double.infinity,
        height: 2,
        color: AppColors.orange,
      ),
      onChanged: onChanged,
      items: items,
    );
  }
}