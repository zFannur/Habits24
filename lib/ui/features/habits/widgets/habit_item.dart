import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/app/router/app_router.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/ui/features/habits/habits.dart';

class HabitItemWidget extends StatelessWidget {
  final Habit habit;

  const HabitItemWidget({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // context.pushRoute(
            //   HabitAddRoute(
            //     habit: habit,
            //     onTap: (habit) {
            //       context.read<HabitsBloc>().add(HabitUpdated(habit));
            //       context.popRoute();
            //     },
            //   ),
            // );
            context.pushRoute(
              HabitDetailRoute(
                habit: habit,
              ),
            );
          },
          child: Container(
            color: AppColors.greyDark,
            padding: AppPadding.v8h20,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    EditableImageWidget(
                      imagePath: habit.imagePath ?? '',
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit.target,
                            style: AppTextStyle.medium20,
                          ),
                          HabitFrequencyInfo(habit: habit),
                          HabitProgressIndicator(habit: habit),
                        ],
                      ),
                    ),
                  ],
                ),
                WeekDaysWidget(habit: habit),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.read<HabitsBloc>().add(HabitMarked(habit, DateTime.now()));
          },
          child: Container(
            padding: AppPadding.all8,
            alignment: Alignment.center,
            width: double.infinity,
            color: AppColors.orange,
            child: const Text(
              'Отметить привычку',
              style: AppTextStyle.mediumBlack20,
            ),
          ),
        ),
      ],
    );
  }
}

class HabitFrequencyInfo extends StatelessWidget {
  final Habit habit;

  const HabitFrequencyInfo({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Повторов: ${habit.frequency}',
          style: AppTextStyle.medium14,
        ),
        Text(
          'Выполнено: ${_getFrequencyToday()}',
          style: AppTextStyle.medium14,
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
