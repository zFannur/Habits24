import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';

class HabitProgressIndicator extends StatelessWidget {
  final Habit habit;

  const HabitProgressIndicator({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    // Вычисляем процент выполнения
    double progress = _calculateProgress();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Прогресс выполнения:',
          style: AppTextStyle.medium14,
        ),
        const SizedBox(height: 8), // Отступ между текстом и индикатором
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.grey,
          color: AppColors.orange,
          minHeight: 10, // Устанавливаем высоту индикатора
        ),
        const SizedBox(height: 4), // Отступ после индикатора
        Text(
          '${(progress * 100).toStringAsFixed(0)}% выполнено',
          style: AppTextStyle.medium14,
        ),
      ],
    );
  }

  double _calculateProgress() {
    if (habit.duration <= 0) return 0; // Предотвращаем деление на ноль

    // Сначала фильтруем completionDates, оставляя только те, для которых completionFrequency > 0
    int uniqueDaysCompleted = habit.completionDates
        .where((completionDate) => completionDate.completionFrequency > 0)
        .map((completionDate) => DateTime(
      completionDate.completionDate.year,
      completionDate.completionDate.month,
      completionDate.completionDate.day,
    ))
        .toSet()
        .length;

    // Вычисляем процент выполнения
    double progress = uniqueDaysCompleted / habit.duration;
    return progress.clamp(0.0, 1.0); // Ограничиваем значение между 0 и 1
  }
}