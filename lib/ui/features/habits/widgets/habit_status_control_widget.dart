import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/ui/features/habits/habits.dart';


class HabitStatusControl extends StatelessWidget {
  final Habit habit;

  const HabitStatusControl({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.v8h20,
      child: Row(
        children: [
          Expanded(child: HabitProgressIndicator(habit: habit)),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  context.read<HabitsBloc>().add(
                    HabitUpdated(habit.copyWith(isCompleted: !habit.isCompleted)),
                  );
                },
                child: Text(
                  habit.isCompleted ? 'Возобновить' : 'Завершить',
                  style: AppTextStyle.medium20,
                ),
              ),
              Text(
                'Статус: ${habit.isCompleted ? 'завершен' : 'выполняется'}',
                style: AppTextStyle.medium14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}