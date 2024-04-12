import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habits24/domain/domain.dart';
import 'package:uuid/v4.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'habits_event.dart';

part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  HabitsBloc({
    required HabitsRepositoryInterface habitsRepository,
  })  : _habitsRepository = habitsRepository,
        super(const HabitsState()) {
    on<HabitsSubscriptionRequested>(_onSubscriptionRequested);
    on<HabitsSearchRequested>(_onHabitsSearchRequested);
    on<HabitAdded>(_onHabitAdded);
    on<HabitUpdated>(_onHabitUpdated);
    on<HabitDeleted>(_onHabitDeleted);
    on<HabitMarked>(_onHabitMarked);
    on<HabitTriggerMarked>(_onHabitTriggerMarked);
    on<HabitActionMarked>(_onHabitActionMarked);
    on<HabitRewardMarked>(_onHabitRewardMarked);
    on<HabitNotificationAdded>(_onScheduleHabitNotification);
    on<HabitNotificationCanceled>(_onCancelNotification);
    on<HabitFilterChanged>(_onFilterChanged);

    _initNotifications();
  }

  final HabitsRepositoryInterface _habitsRepository;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  Future<void> _onScheduleHabitNotification(
    HabitNotificationAdded event,
    Emitter<HabitsState> emit,
  ) async {
    final time = event.time;
    final id = event.id;
    final description = event.description;

    tz.initializeTimeZones();

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'habit_channel_id', // ID канала
      'Habits', // Название канала
      channelDescription: 'Notification channel for habit reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, // Уникальный идентификатор привычки
      'Время выполнить привычку!',
      description,
      scheduledDate,
      platformDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> testNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  Future<void> _onCancelNotification(
    HabitNotificationCanceled event,
    Emitter<HabitsState> emit,
  ) async {
    await flutterLocalNotificationsPlugin.cancel(event.id);
  }

  Future<void> _onSubscriptionRequested(
    HabitsSubscriptionRequested event,
    Emitter<HabitsState> emit,
  ) async {
    emit(state.copyWith(status: () => HabitsStatus.loading));

    await emit.forEach<List<Habit>>(
      _habitsRepository.getHabits(),
      onData: (habits) => state.copyWith(
        status: () => HabitsStatus.success,
        habits: () => habits,
        filteredHabits: () => HabitsFiltered.filter(
            habits, state.filter),
      ),
      onError: (error, __) => state.copyWith(
        status: () => HabitsStatus.failure,
        error: () => error.toString(),
      ),
    );
  }

  Future<void> _onHabitsSearchRequested(
    HabitsSearchRequested event,
    Emitter<HabitsState> emit,
  ) async {
    //await _operationsRepository.searchOperations(event.searchWord);
    emit(state.copyWith(
      searchWord: () => event.searchWord,
      filteredHabits: () => HabitsFiltered.filter(
          state.habits, state.filter),
    ));
  }

  Future<void> _onHabitAdded(
    HabitAdded event,
    Emitter<HabitsState> emit,
  ) async {
    await _habitsRepository.addHabit(event.habit);
  }

  Future<void> _onHabitUpdated(
    HabitUpdated event,
    Emitter<HabitsState> emit,
  ) async {
    await _habitsRepository.updateHabit(event.habit);
  }

  Future<void> _onHabitMarked(
    HabitMarked event,
    Emitter<HabitsState> emit,
  ) async {
    // Используем переданную дату из события вместо текущей даты
    final selectedDate = event.date;
    Habit newHabit = event.habit;
    List<CompletionDate> completionDates = List.from(newHabit.completionDates);

    // Находим записи за выбранную дату
    List<CompletionDate> selectedDateCompletions = completionDates
        .where((element) =>
            element.completionDate.day == selectedDate.day &&
            element.completionDate.year == selectedDate.year &&
            element.completionDate.month == selectedDate.month)
        .toList();

    if (selectedDateCompletions.isNotEmpty) {
      int completionFrequency =
          selectedDateCompletions.first.completionFrequency + 1;

      if (completionFrequency > newHabit.frequency) {
        completionFrequency = 0; // Сбрасываем на 1 вместо обнуления
      }

      final newCompletionDate = CompletionDate(
        id: const UuidV4().generate(), // Убедитесь, что у вас есть генерация ID
        completionFrequency: completionFrequency,
        completionDate: selectedDate,
      );
      completionDates.remove(selectedDateCompletions.first);
      completionDates.add(newCompletionDate);
    } else {
      final newCompletionDate = CompletionDate(
        id: const UuidV4().generate(), // Аналогично, нужен механизм для ID
        completionFrequency: 1,
        completionDate: selectedDate,
      );
      completionDates.add(newCompletionDate);
    }

    // Обновляем привычку с новым списком дат выполнения
    await _habitsRepository.updateHabit(newHabit.copyWith(
      completionDates: completionDates,
    ));
  }

  Future<void> _onHabitTriggerMarked(
    HabitTriggerMarked event,
    Emitter<HabitsState> emit,
  ) async {
    final selectedDate = event.date; // Используем переданную дату из события
    Habit eventHabit = event.habit;
    Trigger eventTrigger = event.trigger;
    TriggerQuestion triggerQuestion = event.triggerQuestion;

    // Находим и обновляем completionDates для конкретного trigger
    final updatedTriggers = eventHabit.triggers.map((trigger) {
      if (trigger.id != eventTrigger.id) {
        return trigger; // Если не наш trigger, возвращаем без изменений
      }

      // Обрабатываем completionDates для найденного trigger
      final completionDates =
          List<CompletionDateTrigger>.from(trigger.completionDates);

      final index = completionDates.indexWhere((cd) =>
          cd.completionDate.day == selectedDate.day &&
          cd.completionDate.month == selectedDate.month &&
          cd.completionDate.year == selectedDate.year);

      if (index != -1) {
        final oldCompletionDate = completionDates[index];
        final updatedCompletionDate = oldCompletionDate.copyWith(
          completionFrequency: oldCompletionDate.completionFrequency + 1,
          triggerQuestion: triggerQuestion,
        );
        completionDates[index] = updatedCompletionDate;
      } else {
        completionDates.add(CompletionDateTrigger(
          id: const UuidV4().generate(),
          completionFrequency: 1,
          completionDate: selectedDate,
          triggerQuestion: triggerQuestion,
        ));
      }

      return trigger.copyWith(
          completionDates: completionDates); // Возвращаем обновленный trigger
    }).toList();

    // Обновляем привычку с обновленным списком triggers
    await _habitsRepository
        .updateHabit(eventHabit.copyWith(triggers: updatedTriggers));
  }

  Future<void> _onHabitActionMarked(
    HabitActionMarked event,
    Emitter<HabitsState> emit,
  ) async {
    final selectedDate = event.date;
    Habit habit = event.habit;
    ActionHabit actionHabit = event.actionHabit;

    // Обновляем completionDates для конкретного actionHabit
    final updatedActions = habit.actions.map((action) {
      if (action.id != actionHabit.id) {
        return action; // Если не наш actionHabit, возвращаем без изменений
      }

      // Обновляем completionDates
      final completionDates =
          List<CompletionDateAction>.from(action.completionDates);

      final index = completionDates.indexWhere((cd) =>
          cd.completionDate.day == selectedDate.day &&
          cd.completionDate.month == selectedDate.month &&
          cd.completionDate.year == selectedDate.year);

      if (index != -1) {
        final triggers = List<String>.from(completionDates[index].triggers)
          ..add(event.trigger);
        final oldCompletionDate = completionDates[index];
        final updatedCompletionDate = oldCompletionDate.copyWith(
          completionFrequency: oldCompletionDate.completionFrequency + 1,
          triggers: triggers,
        );
        completionDates[index] = updatedCompletionDate;
      } else {
        completionDates.add(CompletionDateAction(
          id: const UuidV4().generate(),
          completionFrequency: 1,
          completionDate: selectedDate,
          triggers: [event.trigger],
        ));
      }

      return action.copyWith(
        completionDates: completionDates,
      ); // Возвращаем обновленный actionHabit
    }).toList();

    // Обновляем привычку с обновленным списком actions
    await _habitsRepository
        .updateHabit(habit.copyWith(actions: updatedActions));
  }

  Future<void> _onHabitRewardMarked(
    HabitRewardMarked event,
    Emitter<HabitsState> emit,
  ) async {
    final selectedDate = event.date;
    Habit newHabit = event.habit;

    // Обновляем completionDates для конкретного reward
    final updatedRewards = newHabit.rewards.map((reward) {
      if (reward.id != event.reward.id) {
        return reward; // Если не наш reward, возвращаем без изменений
      }

      // Обновляем completionDates
      final completionDates =
          List<CompletionDateReward>.from(reward.completionDates);

      final index = completionDates.indexWhere((cd) =>
          cd.completionDate.day == selectedDate.day &&
          cd.completionDate.month == selectedDate.month &&
          cd.completionDate.year == selectedDate.year);

      if (index != -1) {
        final actions = List<String>.from(completionDates[index].actions)
          ..add(event.action);
        final words = List<String>.from(completionDates[index].words)
          ..add(event.words);
        final oldCompletionDate = completionDates[index];
        final updatedCompletionDate = oldCompletionDate.copyWith(
          completionFrequency: oldCompletionDate.completionFrequency + 1,
          actions: actions,
          words: words,
        );
        completionDates[index] = updatedCompletionDate;
      } else {
        completionDates.add(CompletionDateReward(
          id: const UuidV4().generate(),
          completionFrequency: 1,
          completionDate: selectedDate,
          actions: [event.action],
          words: [event.words],
        ));
      }

      return reward.copyWith(
        completionDates: completionDates,
      ); // Возвращаем обновленный reward
    }).toList();

    // Обновляем привычку с обновленным списком rewards
    await _habitsRepository
        .updateHabit(newHabit.copyWith(rewards: updatedRewards));
  }

  Future<void> _onHabitDeleted(
    HabitDeleted event,
    Emitter<HabitsState> emit,
  ) async {
    await _habitsRepository.deleteHabit(event.habit);
  }

void _onFilterChanged(
  HabitFilterChanged event,
  Emitter<HabitsState> emit,
) {
  emit(state.copyWith(
    filter: () => event.filter,
    filteredHabits: () => HabitsFiltered.filter(
        state.habits, event.filter),
  ));
}
}
