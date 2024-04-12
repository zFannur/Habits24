import 'package:habits24/data/data.dart';

abstract interface class HabitsLocalStorageInterface {
  Stream<List<HabitDto>> getHabits();
  Future<List<HabitDto>> searchHabits(String searchWord);
  Future<void> addHabit(HabitDto habit);
  Future<void> updateHabit(HabitDto habit);
  Future<void> deleteHabit(HabitDto habit);
  Future<void> addFromFile(List<HabitDto> habit, {bool delete = true});
}

class HabitNotFoundException implements Exception {}
