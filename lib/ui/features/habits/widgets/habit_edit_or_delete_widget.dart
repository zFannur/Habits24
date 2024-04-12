import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/ui/features/habits/habits.dart';

class HabitEditOrDeleteWidget extends StatelessWidget {
  const HabitEditOrDeleteWidget({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            context.pushRoute(
              HabitAddRoute(
                habit: habit,
                onTap: (habit) {
                  context.read<HabitsBloc>().add(HabitUpdated(habit));
                  context.popRoute();
                },
              ),
            );
          },
          child: const Text(
            'Редактировать',
            style: AppTextStyle.medium20,
          ),
        ),
        TextButton(
          onPressed: () {
            context.popRoute();
            context.read<HabitsBloc>().add(HabitDeleted(habit));
          },
          child: const Text(
            'Удалить',
            style: AppTextStyle.medium20,
          ),
        ),
      ],
    );
  }
}