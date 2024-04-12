import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'dart:math' as math;

class HabitLoopsWidget extends StatelessWidget {
  final List<Trigger> triggers;
  final List<ActionHabit> actions;
  final List<Reward> rewards;

  const HabitLoopsWidget({
    super.key,
    required this.triggers,
    required this.actions,
    required this.rewards,
  });

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  bool isContainTrigger(Trigger trigger, List<String> actionHabitTriggers) {
    return actionHabitTriggers.contains(trigger.name);
  }

  bool isContainAction(ActionHabit actionHabit, List<String> rewardActions) {
    return rewardActions.contains(actionHabit.name);
  }

  List<Map<String, dynamic>> findHabitLoops() {
    List<Map<String, dynamic>> habitLoops = [];

    for (var trigger in triggers) {
      for (var action in actions) {
        for (var reward in rewards) {
          var loopOccurrences = <DateTime, int>{};

          for (var triggerDate in trigger.completionDates) {
            var actionMatchCount = action.completionDates
                .where((actionDate) => isSameDay(
                    triggerDate.completionDate, actionDate.completionDate))
                .fold<int>(
                    0,
                    (total, a) =>
                        total +
                        a.triggers.where((t) => t == trigger.name).length);

            var rewardMatchCount = reward.completionDates
                .where((rewardDate) => isSameDay(
                    triggerDate.completionDate, rewardDate.completionDate))
                .fold<int>(
                    0,
                    (total, r) =>
                        total +
                        r.actions.where((a) => a == action.name).length);

            var loopCount = math.min(actionMatchCount, rewardMatchCount);
            if (loopCount > 0) {
              var keyDate = DateTime(
                  triggerDate.completionDate.year,
                  triggerDate.completionDate.month,
                  triggerDate.completionDate.day);
              loopOccurrences.update(keyDate, (value) => value + loopCount,
                  ifAbsent: () => loopCount);
            }
          }

          loopOccurrences.forEach((date, frequency) {
            habitLoops.add({
              'triggerName': trigger.name,
              'actionName': action.name,
              'rewardName': reward.name,
              'date': date,
              'completionFrequency': frequency,
            });
          });
        }
      }
    }

    return habitLoops;
  }

  @override
  Widget build(BuildContext context) {
    var habitLoops = findHabitLoops();
    final format = DateFormat('dd.MM.yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: AppPadding.horizontal16,
          child: Text(
            'Петли привычек',
            style: AppTextStyle.bold24,
          ),
        ),
        Column(
          children: List.generate(
            habitLoops.length,
            (index) {
              var loop = habitLoops[index];
              return ListTile(
                title: Text(
                  '${loop['triggerName']} -> ${loop['actionName']} -> ${loop['rewardName']}',
                  style: AppTextStyle.bold14,
                ),
                subtitle: Text(
                  'Дата: ${format.format(loop['date'])} - Выполнений: ${loop['completionFrequency']}',
                  style: AppTextStyle.bold14,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
