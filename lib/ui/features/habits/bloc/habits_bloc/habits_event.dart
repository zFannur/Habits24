part of 'habits_bloc.dart';

sealed class HabitsEvent extends Equatable {
  const HabitsEvent();

  @override
  List<Object> get props => [];
}

final class HabitsSubscriptionRequested extends HabitsEvent {
  const HabitsSubscriptionRequested();
}

final class HabitsSearchRequested extends HabitsEvent {
  const HabitsSearchRequested(this.searchWord);

  final String searchWord;

  @override
  List<Object> get props => [searchWord];
}

final class HabitDeleted extends HabitsEvent {
  const HabitDeleted(this.habit);

  final Habit habit;

  @override
  List<Object> get props => [habit];
}

final class HabitUpdated extends HabitsEvent {
  const HabitUpdated(this.habit);

  final Habit habit;

  @override
  List<Object> get props => [habit];
}

class HabitMarked extends HabitsEvent {
  final Habit habit;
  final DateTime date;

  const HabitMarked(this.habit, this.date);

  @override
  List<Object> get props => [habit, date];
}

class HabitTriggerMarked extends HabitsEvent {
  final Habit habit;
  final DateTime date;
  final Trigger trigger;
  final TriggerQuestion triggerQuestion;

  const HabitTriggerMarked(
    this.habit,
    this.date,
    this.trigger,
    this.triggerQuestion,
  );

  @override
  List<Object> get props => [habit, date, trigger, triggerQuestion];
}

class HabitActionMarked extends HabitsEvent {
  final Habit habit;
  final DateTime date;
  final ActionHabit actionHabit;
  final String trigger;

  const HabitActionMarked(this.habit, this.date, this.actionHabit, this.trigger);

  @override
  List<Object> get props => [habit, date, actionHabit, trigger];
}

class HabitRewardMarked extends HabitsEvent {
  final Habit habit;
  final DateTime date;
  final Reward reward;
  final String action;
  final String words;

  const HabitRewardMarked(this.habit, this.date, this.reward, this.action, this.words,);

  @override
  List<Object> get props => [habit, date, reward, action, words];
}

final class HabitAdded extends HabitsEvent {
  const HabitAdded(this.habit);

  final Habit habit;

  @override
  List<Object> get props => [habit];
}

final class HabitNotificationAdded extends HabitsEvent {
  const HabitNotificationAdded( this.time, this.id, this.description);

  final int id;
  final String description;
  final DateTime time;

  @override
  List<Object> get props => [id, time, description];
}

final class HabitNotificationCanceled extends HabitsEvent {
  const HabitNotificationCanceled(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

final class HabitFilterChanged extends HabitsEvent {
  const HabitFilterChanged(this.filter);

  final HabitsFilter filter;

  @override
  List<Object> get props => [filter];
}
