import 'package:habits24/data/data.dart';
import 'package:habits24/domain/domain.dart';
import 'package:realm/realm.dart';
import 'package:uuid/v4.dart';

class Converter {
  Converter._();

  // Конвертер из HabitDto в Habit
  static Habit fromHabitDto(HabitDto realmHabit) {
    return Habit(
      id: realmHabit.id,
      imagePath: realmHabit.imagePath,
      target: realmHabit.target,
      description: realmHabit.description,
      isCompleted: realmHabit.isCompleted,
      triggers: realmHabit.triggers
          .map((trigger) => Trigger(
                id: trigger.id,
                name: trigger.name,
                completionDates: trigger.completionDates
                    .map(
                      (completionDate) => CompletionDateTrigger(
                        id: completionDate.base?.id ??
                            const UuidV4().generate(),
                        completionFrequency:
                            completionDate.base?.completionFrequency ?? 0,
                        completionDate: DateTime.fromMillisecondsSinceEpoch(
                          completionDate.base?.completionDate ?? 0,
                        ),
                        triggerQuestion: TriggerQuestion(
                          location:
                              completionDate.triggerQuestion?.location ?? '',
                          time: completionDate.triggerQuestion?.time ?? '',
                          emotionalState:
                              completionDate.triggerQuestion?.emotionalState ??
                                  '',
                          otherPeople:
                              completionDate.triggerQuestion?.otherPeople ?? '',
                          priorAction:
                              completionDate.triggerQuestion?.priorAction ?? '',
                        ),
                      ),
                    )
                    .toList(),
              ))
          .toList(),
      actions: realmHabit.actions
          .map((action) => ActionHabit(
                id: action.id,
                name: action.name,
                completionDates: action.completionDates
                    .map(
                      (completionDate) => CompletionDateAction(
                        id: completionDate.base?.id ??
                            const UuidV4().generate(),
                        completionFrequency:
                            completionDate.base?.completionFrequency ?? 0,
                        completionDate: DateTime.fromMillisecondsSinceEpoch(
                          completionDate.base?.completionDate ?? 0,
                        ),
                        triggers: completionDate.triggers.toList(),
                      ),
                    )
                    .toList(),
              ))
          .toList(),
      rewards: realmHabit.rewards
          .map((reward) => Reward(
                id: reward.id,
                name: reward.name,
                actions: reward.actions.toList(),
                completionDates: reward.completionDates
                    .map(
                      (completionDate) => CompletionDateReward(
                        id: completionDate.base?.id ??
                            const UuidV4().generate(),
                        completionFrequency:
                            completionDate.base?.completionFrequency ?? 0,
                        completionDate: DateTime.fromMillisecondsSinceEpoch(
                          completionDate.base?.completionDate ?? 0,
                        ),
                        words: completionDate.words.toList(),
                        actions: completionDate.actions.toList(),
                      ),
                    )
                    .toList(),
              ))
          .toList(),
      support: realmHabit.support.toList(),
      frequency: realmHabit.frequency,
      duration: realmHabit.duration,
      time: realmHabit.time
          .map((e) => DateTime.fromMillisecondsSinceEpoch(e))
          .toList(),
      completionDates: realmHabit.completionDates
          .map(
            (completionDate) => CompletionDate(
              id: completionDate.id,
              completionFrequency: completionDate.completionFrequency,
              completionDate: DateTime.fromMillisecondsSinceEpoch(
                completionDate.completionDate,
              ),
            ),
          )
          .toList(),
      plan: realmHabit.plan != null
          ? HabitPlan(
              id: realmHabit.plan?.id ?? const UuidV4().generate(),
              name: realmHabit.plan?.name ?? '',
              description: realmHabit.plan?.description ?? '',
              gives: realmHabit.plan?.gives.toList() ?? [],
              takes: realmHabit.plan?.takes.toList() ?? [],
              progress: realmHabit.plan?.progress
                      .map((item) => Progress(
                            id: item.id,
                            imagePath: item.imagePath,
                            description: item.description,
                            time:
                                DateTime.fromMillisecondsSinceEpoch(item.time),
                          ))
                      .toList() ??
                  [],
            )
          : null,
    );
  }

// Конвертер из Habit в HabitDto
  static HabitDto toHabitDto(Habit habit) {
    final triggers =
        RealmList<TriggerDto>(habit.triggers.map((trigger) => TriggerDto(
              trigger.id,
              trigger.name,
              completionDates: trigger.completionDates
                  .map(
                    (completionDate) => CompletionDateTriggerDto(
                      base: CompletionDateDto(
                        completionDate.id,
                        completionDate.completionFrequency,
                        completionDate.completionDate.millisecondsSinceEpoch,
                      ),
                      triggerQuestion: TriggerQuestionDto(
                        completionDate.triggerQuestion.location,
                        completionDate.triggerQuestion.time,
                        completionDate.triggerQuestion.emotionalState,
                        completionDate.triggerQuestion.otherPeople,
                        completionDate.triggerQuestion.priorAction,
                      ),
                    ),
                  )
                  .toList(),
            )));
    final actions =
        RealmList<ActionHabitDto>(habit.actions.map((action) => ActionHabitDto(
              action.id,
              action.name,
              completionDates: action.completionDates
                  .map(
                    (completionDate) => CompletionDateActionDto(
                      base: CompletionDateDto(
                        completionDate.id,
                        completionDate.completionFrequency,
                        completionDate.completionDate.millisecondsSinceEpoch,
                      ),
                      triggers: completionDate.triggers,
                    ),
                  )
                  .toList(),
            )));
    final reward = RealmList<RewardDto>(habit.rewards.map((reward) => RewardDto(
          reward.id,
          reward.name,
          completionDates: reward.completionDates.map(
            (item) => CompletionDateRewardDto(
              base: CompletionDateDto(
                item.id,
                item.completionFrequency,
                item.completionDate.millisecondsSinceEpoch,
              ),
              words: item.words,
              actions: item.actions,
            ),
          ),
        )));
    final support = RealmList<String>(habit.support);

    final completionDates =
        RealmList<CompletionDateDto>(habit.completionDates.map(
      (completionDate) => CompletionDateDto(
        completionDate.id,
        completionDate.completionFrequency,
        completionDate.completionDate.millisecondsSinceEpoch,
      ),
    ));

    final plan = habit.plan != null
        ? HabitPlanDto(
            habit.plan?.id ?? const UuidV4().generate(),
            habit.plan?.name ?? '',
            habit.plan?.description ?? '',
            gives: habit.plan?.gives ?? [],
            takes: habit.plan?.takes ?? [],
            progress: habit.plan?.progress.map((item) => ProgressDto(
                      item.id,
                      item.imagePath,
                      item.description,
                      item.time.millisecondsSinceEpoch,
                    )) ??
                [],
          )
        : null;

    return HabitDto(
      habit.id,
      habit.target,
      habit.description,
      habit.frequency,
      habit.duration,
      habit.isCompleted,
      plan: plan,
      triggers: triggers,
      actions: actions,
      rewards: reward,
      support: support,
      completionDates: completionDates,
      imagePath: habit.imagePath,
      time: RealmList<int>(habit.time.map((e) => e.millisecondsSinceEpoch)),
    );
  }

// static Plan fromPlanDto(PlanDto dto) {
//   return Plan(
//     id: dto.id,
//     date: DateTime.fromMillisecondsSinceEpoch(dto.date),
//     type: const TypeConverter().fromJson(dto.type),
//     category: dto.category,
//     sum: dto.sum,
//     note: dto.note,
//   );
// }
// static PlanDto toPlanDto(Plan plan) {
//   return PlanDto(
//     plan.id,
//     const TypeConverter().toJson(plan.type),
//     plan.category,
//     plan.sum,
//     plan.date.millisecondsSinceEpoch,
//     plan.note,
//   );
// }
}
