import 'package:habits24/domain/domain.dart';

abstract interface class HabitsRepositoryInterface {
  Stream<List<Habit>> getHabits();
  Future<List<Habit>> searchHabits(String searchWord);
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(Habit habit);
  Future<void> addFromFile(List<Habit> habit, {bool delete = true});
}
