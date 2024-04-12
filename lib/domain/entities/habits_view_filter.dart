import 'habit.dart';

class HabitsFilter {
  final bool isCompleted;
  final bool ascending;
  final bool descending;

  const HabitsFilter({
    this.isCompleted = false,
    this.ascending = true,
    this.descending = false,
  });

  HabitsFilter copyWith({
    bool? isCompleted,
    bool? ascending,
    bool? descending,
  }) {
    return HabitsFilter(
      isCompleted: isCompleted ?? this.isCompleted,
      ascending: ascending ?? this.ascending,
      descending: descending ?? this.descending,
    );
  }
}

class HabitsFiltered {
  static List<Habit> filter(List<Habit> habits, HabitsFilter filter) {
    List<Habit> filteredHabits = List.from(habits);

    if (filter.isCompleted) {
      filteredHabits = filteredHabits.where((element) => element.isCompleted).toList();
    } else {
      filteredHabits = filteredHabits.where((element) => !element.isCompleted).toList();
    }

    return filteredHabits;
  }
}