import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/generated/locale_keys.g.dart';
import 'package:habits24/ui/features/habits/habits.dart';

@RoutePage()
class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(name: habit.target, withArrowBack: true),
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          if (state.habits.isEmpty) {
            return const SizedBox.shrink();
          }

          final updatedHabit =
              state.habits.where((element) => element.id == habit.id).first;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HabitEditOrDeleteWidget(habit: updatedHabit),
                // изображение
                EditableImageWidget(
                  width: double.infinity,
                  height: 200,
                  editable: false,
                  imagePath: updatedHabit.imagePath ?? '',
                ),
                //прогресс выполнения за день
                HabitFrequencyInfoWidget(habit: updatedHabit),
                //описание
                Padding(
                  padding: AppPadding.horizontal16,
                  child: Text(
                    updatedHabit.description,
                    style: AppTextStyle.medium20,
                  ),
                ),
                //прогресс неделя
                const Padding(
                  padding: AppPadding.horizontal16,
                  child: Text(
                    'Прогресс неделя',
                    style: AppTextStyle.medium20,
                  ),
                ),
                WeekDaysWidget(habit: updatedHabit),
                //статус привычки
                HabitStatusControl(habit: updatedHabit),
                //Триггеры
                ExpansionPanelWidget(
                  title: 'Триггеры',
                  body: HabitSection(
                    items: updatedHabit.triggers,
                    onTapDate: (item, date) {
                      final TextEditingController controllerLocation =
                          TextEditingController();
                      final TextEditingController controllerTime =
                          TextEditingController();
                      final TextEditingController controllerEmotionalState =
                          TextEditingController();
                      final TextEditingController controllerOtherPeople =
                          TextEditingController();
                      final TextEditingController controllerPriorAction =
                          TextEditingController();

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final theme = Theme.of(context);

                            return AppDialogWidget(
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(LocaleKeys.back.tr(),
                                          style: theme.textTheme.titleMedium),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final triggerQuestion = TriggerQuestion(
                                          location: controllerLocation.text,
                                          time: controllerTime.text,
                                          emotionalState:
                                              controllerEmotionalState.text,
                                          otherPeople: controllerOtherPeople.text,
                                          priorAction: controllerPriorAction.text,
                                        );
                                        context.read<HabitsBloc>().add(
                                            HabitTriggerMarked(updatedHabit, date,
                                                item, triggerQuestion));
                                        context.maybePop();
                                      },
                                      child: Text(LocaleKeys.add.tr(),
                                          style: theme.textTheme.titleMedium),
                                    ),
                                  ],
                                ),
                              ],
                              title: 'Триггер',
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AppTextField(
                                      labelText: 'Локация',
                                      controller: controllerLocation,
                                    ),
                                    const SizedBox(height: 8),
                                    AppTextField(
                                      labelText: 'Время',
                                      controller: controllerTime,
                                    ),
                                    const SizedBox(height: 8),
                                    AppTextField(
                                      labelText: 'Емоции',
                                      controller: controllerEmotionalState,
                                    ),
                                    const SizedBox(height: 8),
                                    AppTextField(
                                      labelText: 'Люди',
                                      controller: controllerOtherPeople,
                                    ),
                                    const SizedBox(height: 8),
                                    AppTextField(
                                      labelText: 'Что делал',
                                      controller: controllerPriorAction,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    onTapItem: (item) {
                      final trigger = item as Trigger;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            List<CompletionDateTrigger> sortedCompletionDates =
                                List.from(trigger.completionDates)
                                  ..sort((a, b) => a.completionDate
                                      .compareTo(b.completionDate));

                            return AppDialogWidget(
                              title: trigger.name,
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(LocaleKeys.back.tr(),
                                      style: AppTextStyle.medium20),
                                ),
                              ],
                              child: TriggerItemInfoWidget(
                                completionDateTrigger: sortedCompletionDates,
                              ),
                            );
                          });
                    },
                  ),
                ),
                //Действия
                ExpansionPanelWidget(
                  title: 'Действия',
                  body: HabitSection(
                    items: updatedHabit.actions,
                    onTapDate: (item, date) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppDialogWidget(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(LocaleKeys.back.tr(),
                                      style: AppTextStyle.medium20),
                                ),
                              ],
                              title: 'Действие',
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: List.generate(
                                      updatedHabit.triggers.length, (index) {
                                    final trigger =
                                        updatedHabit.triggers[index].name;
                                    return InkWell(
                                      onTap: () {
                                        context.read<HabitsBloc>().add(
                                            HabitActionMarked(updatedHabit, date,
                                                item, trigger));
                                        context.maybePop();
                                      },
                                      child: Container(
                                        margin: AppPadding.v8h8,
                                        padding: AppPadding.v8h20,
                                        decoration: BoxDecoration(
                                          color: AppColors.grey,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          trigger,
                                          style: AppTextStyle.bold14,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            );
                          });
                    },
                    onTapItem: (item) {
                      final action = item as ActionHabit;
                      final format = DateFormat('dd.MM.yyyy');

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppDialogWidget(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(LocaleKeys.back.tr(),
                                      style: AppTextStyle.medium20),
                                ),
                              ],
                              title: action.name,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Column(
                                      children: List.generate(
                                          action.completionDates.length, (index) {
                                        final completionDate =
                                            action.completionDates[index];
                                        return Container(
                                          margin: AppPadding.top8,
                                          padding: AppPadding.v8h20,
                                          decoration: BoxDecoration(
                                            color: AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Дата: ${format.format(completionDate.completionDate)}',
                                                style: AppTextStyle.bold14,
                                              ),
                                              const Divider(),
                                              Text(
                                                'Триггеры: ${completionDate.triggers}',
                                                style: AppTextStyle.bold14,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
                //Награды
                ExpansionPanelWidget(
                  title: 'Награды',
                  body: HabitSection(
                    items: updatedHabit.rewards,
                    onTapDate: (item, date) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final TextEditingController controllerWords =
                                TextEditingController();

                            return AppDialogWidget(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(LocaleKeys.back.tr(),
                                      style: AppTextStyle.medium20),
                                ),
                              ],
                              title: 'Награда',
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AppTextField(
                                      labelText: 'Слова',
                                      controller: controllerWords,
                                    ),
                                    Padding(
                                      padding: AppPadding.top8,
                                      child: Wrap(
                                        children: List.generate(
                                            updatedHabit.actions.length, (index) {
                                          final action =
                                              updatedHabit.actions[index].name;
                                          return InkWell(
                                            onTap: () {
                                              context
                                                  .read<HabitsBloc>()
                                                  .add(HabitRewardMarked(
                                                    updatedHabit,
                                                    date,
                                                    item,
                                                    action,
                                                    controllerWords.text,
                                                  ));
                                              context.maybePop();
                                            },
                                            child: Container(
                                              margin: AppPadding.v8h8,
                                              padding: AppPadding.v8h20,
                                              decoration: BoxDecoration(
                                                color: AppColors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Text(
                                                action,
                                                style: AppTextStyle.bold14,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    onTapItem: (item) {
                      final reward = item as Reward;
                      final format = DateFormat('dd.MM.yyyy');

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppDialogWidget(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(LocaleKeys.back.tr(),
                                      style: AppTextStyle.medium20),
                                ),
                              ],
                              title: reward.name,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Column(
                                      children: List.generate(
                                          reward.completionDates.length, (index) {
                                        final completionDate =
                                            reward.completionDates[index];
                                        return Container(
                                          margin: AppPadding.top8,
                                          padding: AppPadding.v8h20,
                                          decoration: BoxDecoration(
                                            color: AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Дата: ${format.format(completionDate.completionDate)}',
                                                style: AppTextStyle.bold14,
                                              ),
                                              const Divider(),
                                              Text(
                                                'Действия: ${completionDate.actions}',
                                                style: AppTextStyle.bold14,
                                              ),
                                              const Divider(),
                                              Text(
                                                'Слова: ${completionDate.words}',
                                                style: AppTextStyle.bold14,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
                //Петли привычек
                HabitLoopsWidget(
                  triggers: updatedHabit.triggers,
                  actions: updatedHabit.actions,
                  rewards: updatedHabit.rewards,
                ),
                //План в особо тажкое время
                HabitDetailsColumn(
                  title: 'В особо тажкое время я:',
                  items: updatedHabit.support,
                ),
                PlanWidget(
                  habitPlan: updatedHabit.plan,
                  onTapEdit: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            HabitPlanEditDialogWidget(
                              habitPlan: updatedHabit.plan,
                              onTap: (habitPlan) {
                                context.read<HabitsBloc>().add(HabitUpdated(
                                      updatedHabit.copyWith(plan: habitPlan),
                                    ));
                                context.maybePop();
                              },
                            ));
                  },
                  onTapProgress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            HabitPlanProgressDialogWidget(
                              habitPlan: updatedHabit.plan,
                              onTap: (habitPlan) {
                                context.read<HabitsBloc>().add(HabitUpdated(
                                      updatedHabit.copyWith(plan: habitPlan),
                                    ));
                                context.maybePop();
                              },
                            ));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
