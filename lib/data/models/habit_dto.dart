import 'package:realm/realm.dart';

part 'habit_dto.g.dart';

@RealmModel()
class _CompletionDateDto {
  @PrimaryKey()
  late String id;

  late int completionFrequency;
  late int completionDate;
}

// Для наследования от CompletionDate и добавления дополнительных полей,
// Realm требует использования композиции вместо наследования
@RealmModel()
class _CompletionDateRewardDto {
  late _CompletionDateDto? base; // Ссылка на базовый объект CompletionDate
  late List<String> words; // Предположим, что это будет преобразовано в поддерживаемый формат
  late List<String> actions;
}

@RealmModel()
class _TriggerQuestionDto {
  late String location;
  late String time;
  late String emotionalState;
  late String otherPeople;
  late String priorAction;
}

@RealmModel()
class _TriggerDto {
  @PrimaryKey()
  late String id;

  late String name;
  late List<_CompletionDateTriggerDto> completionDates; // Используется RealmList для коллекций
}

// Использование композиции для CompletionDateTrigger, как и в случае с CompletionDateReward
@RealmModel()
class _CompletionDateTriggerDto {
  late _CompletionDateDto? base; // Ссылка на базовый объект CompletionDate
  late _TriggerQuestionDto? triggerQuestion; // Ссылка на TriggerQuestion
}

@RealmModel()
class _CompletionDateActionDto {
  late _CompletionDateDto? base; // Ссылка на базовый объект CompletionDate
  late List<String> triggers;
}

@RealmModel()
class _ActionHabitDto {
  @PrimaryKey()
  late String id;

  late String name;
  late List<String> triggers;
  late List<_CompletionDateActionDto> completionDates; // Используется RealmList
}

@RealmModel()
class _RewardDto {
  @PrimaryKey()
  late String id;

  late String name;
  late List<String> actions;
  late List<_CompletionDateRewardDto> completionDates; // Используется RealmList
}

@RealmModel()
class _ProgressDto {
  @PrimaryKey()
  late String id;

  late String imagePath;
  late String description;
  late int time;
}

@RealmModel()
class _HabitPlanDto {
  @PrimaryKey()
  late String id;

  late String name;
  late String description;
  late List<String> gives; // Прямая поддержка списков базовых типов
  late List<String> takes;
  late List<_ProgressDto> progress; // Используется RealmList для коллекций объектов
}

@RealmModel()
class _HabitDto {
  @PrimaryKey()
  late String id;

  late String? imagePath; // Опциональное поле
  late String target;
  late String description;
  late double frequency;
  late int duration;

  // Для хранения DateTime как строки, так как Realm не поддерживает DateTime напрямую
  late List<int> time;

  // Связь один ко многим с HabitPlan
  late _HabitPlanDto? plan;

  // Связи один ко многим для триггеров, действий, наград и поддержки
  late List<_TriggerDto> triggers;
  late List<_ActionHabitDto> actions;
  late List<_RewardDto> rewards;
  late List<String> support; // Простой список строк для поддержки

  late bool isCompleted;

  // Преобразование списка дат выполнения в поддерживаемый формат
  late List<_CompletionDateDto> completionDates;
}