import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/ui/features/habits/habits.dart';

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    super.key,
    required this.habitPlan,
    required this.onTapEdit,
    required this.onTapProgress,
  });

  final HabitPlan? habitPlan;
  final VoidCallback onTapEdit;
  final VoidCallback onTapProgress;

  @override
  Widget build(BuildContext context) {
    final isPlanAvailable = habitPlan != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: AppPadding.horizontal16,
              child: Text('План', style: AppTextStyle.bold24),
            ),
            IconButton(
              onPressed: onTapEdit,
              icon: isPlanAvailable ? AppIcons.edit : AppIcons.add,
            ),
            if (isPlanAvailable)
              TextButton(
                onPressed: onTapProgress,
                child: const Text('Добавить прогресс',
                    style: AppTextStyle.medium14),
              ),
          ],
        ),
        if (isPlanAvailable) _buildPlanDetails(context),
      ],
    );
  }

  Widget _buildPlanDetails(BuildContext context) {
    final format = DateFormat('dd.MM.yyyy');

    return Container(
      margin: AppPadding.v8h20,
      width: double.infinity,
      padding: AppPadding.v8h20,
      decoration: BoxDecoration(
        color: AppColors.greyDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(habitPlan!.name,
              overflow: TextOverflow.fade, style: AppTextStyle.medium20),
          const Divider(),
          Text(habitPlan!.description,
              overflow: TextOverflow.fade, style: AppTextStyle.medium20),
          const Divider(),
          HabitDetailsColumn(
              title: 'Вред от привычки', items: habitPlan!.takes),
          const Divider(),
          HabitDetailsColumn(
              title: 'Польза от привычки', items: habitPlan!.gives),
          const Divider(),
          const Text('Прогресс', style: AppTextStyle.bold24),
          const SizedBox(height: 16),
          ...habitPlan!.progress.reversed.map((progress) => Container(
                width: double.infinity,
                margin: AppPadding.top8,
                padding: AppPadding.v8h20,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Дата: ${format.format(progress.time)}',
                      style: AppTextStyle.medium20,
                    ),
                    progress.imagePath.isEmpty
                        ? const SizedBox.shrink()
                        : EditableImageWidget(
                            width: double.infinity,
                            height: 200,
                            imagePath: progress.imagePath,
                          ),
                    Padding(
                      padding: AppPadding.top8,
                      child: Text(progress.description,
                          overflow: TextOverflow.fade,
                          style: AppTextStyle.medium20),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
