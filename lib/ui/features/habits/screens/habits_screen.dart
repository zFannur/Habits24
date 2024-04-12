import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/ui/features/habits/habits.dart';

@RoutePage()
class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          if (state.habits.isEmpty) {
            if (state.status == HabitsStatus.loading) {
              return const AppLoader();
            } else if (state.status != HabitsStatus.success) {
              return const SizedBox();
            } else {
              return const Center(
                child: Text(
                  'Нет привычек',
                  style: AppTextStyle.medium20,
                ),
              );
            }
          }

          if (state.status == HabitsStatus.loading) {
            return const AppLoader();
          }

          return Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      state.filter.isCompleted
                          ? context.read<HabitsBloc>().add(HabitFilterChanged(
                              state.filter.copyWith(isCompleted: false)))
                          : context.read<HabitsBloc>().add(HabitFilterChanged(
                              state.filter.copyWith(isCompleted: true)));
                    },
                    child: state.filter.isCompleted
                        ? const Text(
                            'Не завершенные',
                            style: AppTextStyle.medium14,
                          )
                        : const Text(
                            'Завершенные',
                            style: AppTextStyle.medium14,
                          ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: state.filteredHabits.length,
                    itemBuilder: (BuildContext context, int index) {
                      final habit = state.filteredHabits[index];

                      return HabitItemWidget(habit: habit);
                    }),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(
            HabitAddRoute(
              onTap: (habit) {
                context.read<HabitsBloc>().add(HabitAdded(habit));
                context.maybePop();
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: AppColors.orange,
        ),
      ),
    );
  }
}
