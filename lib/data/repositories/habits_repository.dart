import 'package:habits24/data/data.dart';
import 'package:habits24/domain/domain.dart';

class HabitsRepository implements HabitsRepositoryInterface {
  HabitsRepository(HabitsLocalStorageInterface localStorage)
      : _localStorage = localStorage;

  final HabitsLocalStorageInterface _localStorage;

  @override
  Stream<List<Habit>> getHabits() {
    return _localStorage.getHabits().map((list) {
      return list.map<Habit>(Converter.fromHabitDto).toList();
    });
  }

  @override
  Future<List<Habit>> searchHabits(String searchWord) {
    return _localStorage
        .searchHabits(searchWord)
        .then((list) => list.map<Habit>(Converter.fromHabitDto).toList());
  }

  @override
  Future<void> addHabit(Habit habit) {
    return _localStorage.addHabit(Converter.toHabitDto(habit));
  }

  @override
  Future<void> updateHabit(Habit habit) {
    return _localStorage.updateHabit(Converter.toHabitDto(habit));
  }

  @override
  Future<void> deleteHabit(Habit habit) {
    return _localStorage.deleteHabit(Converter.toHabitDto(habit));
  }

  @override
  Future<void> addFromFile(List<Habit> habits, {bool delete = true}) {
    return _localStorage.addFromFile(habits.map(Converter.toHabitDto).toList(), delete: delete);
  }
}