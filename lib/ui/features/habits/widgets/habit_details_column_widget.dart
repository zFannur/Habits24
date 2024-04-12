import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';

class HabitDetailsColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const HabitDetailsColumn({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    int index = 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPadding.horizontal16,
          child: Text(
            title,
            style: AppTextStyle.bold24,
          ),
        ),
        ...items.map((item) => Container(
          margin: AppPadding.top8,
          width: double.infinity,
          padding: AppPadding.v8h20,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${index++} - $item',
            overflow: TextOverflow.fade,
            style: AppTextStyle.medium20,
          ),
        )),
      ],
    );
  }
}