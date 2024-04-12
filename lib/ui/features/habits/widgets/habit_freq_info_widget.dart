import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';

class HabitFrequencyInfoWidget extends StatelessWidget {
  final Habit habit;

  const HabitFrequencyInfoWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Повторов: ${habit.frequency}',
          style: AppTextStyle.medium20,
        ),
        Text(
          'Выполнено: ${_getFrequencyToday()}',
          style: AppTextStyle.medium20,
        ),
      ],
    );
  }

  // Функция для подсчёта, сколько раз привычка была выполнена сегодня
  int _getFrequencyToday() {
    final date = DateTime.now();
    final completionDate = habit.completionDates.where(
          (cd) =>
      cd.completionDate.year == date.year &&
          cd.completionDate.month == date.month &&
          cd.completionDate.day == date.day,
    );
    if (completionDate.isNotEmpty) {
      return completionDate.first.completionFrequency;
    } else {
      return 0;
    }
  }
}