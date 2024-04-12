part of 'habits_bloc.dart';

enum HabitsStatus { initial, loading, success, failure }

final class HabitsState extends Equatable {
  const HabitsState({
    this.status = HabitsStatus.initial,
    this.habits = const [],
    this.filteredHabits = const [],
    this.filter = const HabitsFilter(),
    this.searchWord,
    this.error,
  });

  final HabitsStatus status;
  final List<Habit> habits;
  final List<Habit> filteredHabits;

  final HabitsFilter filter;
  final String? searchWord;
  final String? error;

  HabitsState copyWith({
    HabitsStatus Function()? status,
    List<Habit> Function()? habits,
    List<Habit> Function()? filteredHabits,
    HabitsFilter Function()? filter,
    String Function()? searchWord,
    String Function()? error,
  }) {
    return HabitsState(
      status: status != null ? status() : this.status,
      habits: habits != null ? habits() : this.habits,
      filteredHabits:
          filteredHabits != null ? filteredHabits() : this.filteredHabits,
      filter: filter != null ? filter() : this.filter,
      searchWord: searchWord != null ? searchWord() : this.searchWord,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        habits,
        filter,
        filteredHabits,
        searchWord,
      ];
}
