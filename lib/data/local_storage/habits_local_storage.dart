import 'package:habits24/data/data.dart';
import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';

class RealmHabitsLocalStorage implements HabitsLocalStorageInterface {
  RealmHabitsLocalStorage(Realm realm) : _realm = realm {
    _init();
  }

  final Realm _realm;

  final _habitsStreamController = BehaviorSubject<List<HabitDto>>.seeded(const []);

  List<HabitDto>? _getValue() => _realm.all<HabitDto>().toList();

  void _setValue(HabitDto habitDto, {bool? update}) {
    _realm.write(() => _realm.add(habitDto, update: update ?? false));
  }

  void _deleteValue(HabitDto habitDto) {
    _realm.write(() {
      final habit = _realm.find<HabitDto>(habitDto.id);
      if (habit != null) {
        _realm.delete(habit);
      } else {
        throw HabitNotFoundException();
      }
    });
  }

  void _init() {
    final habitsDto = _getValue() ?? const [];
    _habitsStreamController.add(habitsDto);
  }

  @override
  Stream<List<HabitDto>> getHabits() => _habitsStreamController.asBroadcastStream();

  @override
  Future<List<HabitDto>> searchHabits(String searchWord) async {
    final searchList = _realm
        .query<HabitDto>(
      "name CONTAINS '$searchWord' OR description CONTAINS '$searchWord'",
    )
        .toList();

    if (searchList.isEmpty) {
      throw HabitNotFoundException();
    } else {
      return searchList;
    }
  }

  @override
  Future<void> addHabit(HabitDto habitDto) async {
    final habits = [..._habitsStreamController.value, habitDto];
    _habitsStreamController.add(habits);
    return _setValue(habitDto);
  }

  @override
  Future<void> updateHabit(HabitDto habitDto) async {
    final habits = [..._habitsStreamController.value];

    final habitIndex = habits.indexWhere((item) => item.id == habitDto.id);
    if (habitIndex != -1) {
      habits[habitIndex] = habitDto;
      _habitsStreamController.add(habits);
      return _setValue(habitDto, update: true);
    } else {
      throw HabitNotFoundException();
    }
  }

  @override
  Future<void> deleteHabit(HabitDto habitDto) async {
    final habits = [..._habitsStreamController.value]
      ..removeWhere((item) => item.id == habitDto.id);
    _habitsStreamController.add(habits);
    return _deleteValue(habitDto);
  }

  @override
  Future<void> addFromFile(List<HabitDto> habits, {bool delete = true}) async {
    if (delete) {
      _realm.write(() {
        _realm.deleteAll<HabitDto>();
        _realm.addAll(habits);
      });
    } else {
      _realm.write(() => _realm.addAll(habits));
    }
    _habitsStreamController.add(habits);
  }
}