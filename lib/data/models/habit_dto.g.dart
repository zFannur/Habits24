// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_dto.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CompletionDateDto extends _CompletionDateDto
    with RealmEntity, RealmObjectBase, RealmObject {
  CompletionDateDto(
    String id,
    int completionFrequency,
    int completionDate,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'completionFrequency', completionFrequency);
    RealmObjectBase.set(this, 'completionDate', completionDate);
  }

  CompletionDateDto._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get completionFrequency =>
      RealmObjectBase.get<int>(this, 'completionFrequency') as int;
  @override
  set completionFrequency(int value) =>
      RealmObjectBase.set(this, 'completionFrequency', value);

  @override
  int get completionDate =>
      RealmObjectBase.get<int>(this, 'completionDate') as int;
  @override
  set completionDate(int value) =>
      RealmObjectBase.set(this, 'completionDate', value);

  @override
  Stream<RealmObjectChanges<CompletionDateDto>> get changes =>
      RealmObjectBase.getChanges<CompletionDateDto>(this);

  @override
  CompletionDateDto freeze() =>
      RealmObjectBase.freezeObject<CompletionDateDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CompletionDateDto._);
    return const SchemaObject(
        ObjectType.realmObject, CompletionDateDto, 'CompletionDateDto', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('completionFrequency', RealmPropertyType.int),
      SchemaProperty('completionDate', RealmPropertyType.int),
    ]);
  }
}

class CompletionDateRewardDto extends _CompletionDateRewardDto
    with RealmEntity, RealmObjectBase, RealmObject {
  CompletionDateRewardDto({
    CompletionDateDto? base,
    Iterable<String> words = const [],
    Iterable<String> actions = const [],
  }) {
    RealmObjectBase.set(this, 'base', base);
    RealmObjectBase.set<RealmList<String>>(
        this, 'words', RealmList<String>(words));
    RealmObjectBase.set<RealmList<String>>(
        this, 'actions', RealmList<String>(actions));
  }

  CompletionDateRewardDto._();

  @override
  CompletionDateDto? get base =>
      RealmObjectBase.get<CompletionDateDto>(this, 'base')
          as CompletionDateDto?;
  @override
  set base(covariant CompletionDateDto? value) =>
      RealmObjectBase.set(this, 'base', value);

  @override
  RealmList<String> get words =>
      RealmObjectBase.get<String>(this, 'words') as RealmList<String>;
  @override
  set words(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get actions =>
      RealmObjectBase.get<String>(this, 'actions') as RealmList<String>;
  @override
  set actions(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CompletionDateRewardDto>> get changes =>
      RealmObjectBase.getChanges<CompletionDateRewardDto>(this);

  @override
  CompletionDateRewardDto freeze() =>
      RealmObjectBase.freezeObject<CompletionDateRewardDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CompletionDateRewardDto._);
    return const SchemaObject(ObjectType.realmObject, CompletionDateRewardDto,
        'CompletionDateRewardDto', [
      SchemaProperty('base', RealmPropertyType.object,
          optional: true, linkTarget: 'CompletionDateDto'),
      SchemaProperty('words', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('actions', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class TriggerQuestionDto extends _TriggerQuestionDto
    with RealmEntity, RealmObjectBase, RealmObject {
  TriggerQuestionDto(
    String location,
    String time,
    String emotionalState,
    String otherPeople,
    String priorAction,
  ) {
    RealmObjectBase.set(this, 'location', location);
    RealmObjectBase.set(this, 'time', time);
    RealmObjectBase.set(this, 'emotionalState', emotionalState);
    RealmObjectBase.set(this, 'otherPeople', otherPeople);
    RealmObjectBase.set(this, 'priorAction', priorAction);
  }

  TriggerQuestionDto._();

  @override
  String get location =>
      RealmObjectBase.get<String>(this, 'location') as String;
  @override
  set location(String value) => RealmObjectBase.set(this, 'location', value);

  @override
  String get time => RealmObjectBase.get<String>(this, 'time') as String;
  @override
  set time(String value) => RealmObjectBase.set(this, 'time', value);

  @override
  String get emotionalState =>
      RealmObjectBase.get<String>(this, 'emotionalState') as String;
  @override
  set emotionalState(String value) =>
      RealmObjectBase.set(this, 'emotionalState', value);

  @override
  String get otherPeople =>
      RealmObjectBase.get<String>(this, 'otherPeople') as String;
  @override
  set otherPeople(String value) =>
      RealmObjectBase.set(this, 'otherPeople', value);

  @override
  String get priorAction =>
      RealmObjectBase.get<String>(this, 'priorAction') as String;
  @override
  set priorAction(String value) =>
      RealmObjectBase.set(this, 'priorAction', value);

  @override
  Stream<RealmObjectChanges<TriggerQuestionDto>> get changes =>
      RealmObjectBase.getChanges<TriggerQuestionDto>(this);

  @override
  TriggerQuestionDto freeze() =>
      RealmObjectBase.freezeObject<TriggerQuestionDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TriggerQuestionDto._);
    return const SchemaObject(
        ObjectType.realmObject, TriggerQuestionDto, 'TriggerQuestionDto', [
      SchemaProperty('location', RealmPropertyType.string),
      SchemaProperty('time', RealmPropertyType.string),
      SchemaProperty('emotionalState', RealmPropertyType.string),
      SchemaProperty('otherPeople', RealmPropertyType.string),
      SchemaProperty('priorAction', RealmPropertyType.string),
    ]);
  }
}

class TriggerDto extends _TriggerDto
    with RealmEntity, RealmObjectBase, RealmObject {
  TriggerDto(
    String id,
    String name, {
    Iterable<CompletionDateTriggerDto> completionDates = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<CompletionDateTriggerDto>>(
        this,
        'completionDates',
        RealmList<CompletionDateTriggerDto>(completionDates));
  }

  TriggerDto._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<CompletionDateTriggerDto> get completionDates =>
      RealmObjectBase.get<CompletionDateTriggerDto>(this, 'completionDates')
          as RealmList<CompletionDateTriggerDto>;
  @override
  set completionDates(covariant RealmList<CompletionDateTriggerDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TriggerDto>> get changes =>
      RealmObjectBase.getChanges<TriggerDto>(this);

  @override
  TriggerDto freeze() => RealmObjectBase.freezeObject<TriggerDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TriggerDto._);
    return const SchemaObject(
        ObjectType.realmObject, TriggerDto, 'TriggerDto', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('completionDates', RealmPropertyType.object,
          linkTarget: 'CompletionDateTriggerDto',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class CompletionDateTriggerDto extends _CompletionDateTriggerDto
    with RealmEntity, RealmObjectBase, RealmObject {
  CompletionDateTriggerDto({
    CompletionDateDto? base,
    TriggerQuestionDto? triggerQuestion,
  }) {
    RealmObjectBase.set(this, 'base', base);
    RealmObjectBase.set(this, 'triggerQuestion', triggerQuestion);
  }

  CompletionDateTriggerDto._();

  @override
  CompletionDateDto? get base =>
      RealmObjectBase.get<CompletionDateDto>(this, 'base')
          as CompletionDateDto?;
  @override
  set base(covariant CompletionDateDto? value) =>
      RealmObjectBase.set(this, 'base', value);

  @override
  TriggerQuestionDto? get triggerQuestion =>
      RealmObjectBase.get<TriggerQuestionDto>(this, 'triggerQuestion')
          as TriggerQuestionDto?;
  @override
  set triggerQuestion(covariant TriggerQuestionDto? value) =>
      RealmObjectBase.set(this, 'triggerQuestion', value);

  @override
  Stream<RealmObjectChanges<CompletionDateTriggerDto>> get changes =>
      RealmObjectBase.getChanges<CompletionDateTriggerDto>(this);

  @override
  CompletionDateTriggerDto freeze() =>
      RealmObjectBase.freezeObject<CompletionDateTriggerDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CompletionDateTriggerDto._);
    return const SchemaObject(ObjectType.realmObject, CompletionDateTriggerDto,
        'CompletionDateTriggerDto', [
      SchemaProperty('base', RealmPropertyType.object,
          optional: true, linkTarget: 'CompletionDateDto'),
      SchemaProperty('triggerQuestion', RealmPropertyType.object,
          optional: true, linkTarget: 'TriggerQuestionDto'),
    ]);
  }
}

class CompletionDateActionDto extends _CompletionDateActionDto
    with RealmEntity, RealmObjectBase, RealmObject {
  CompletionDateActionDto({
    CompletionDateDto? base,
    Iterable<String> triggers = const [],
  }) {
    RealmObjectBase.set(this, 'base', base);
    RealmObjectBase.set<RealmList<String>>(
        this, 'triggers', RealmList<String>(triggers));
  }

  CompletionDateActionDto._();

  @override
  CompletionDateDto? get base =>
      RealmObjectBase.get<CompletionDateDto>(this, 'base')
          as CompletionDateDto?;
  @override
  set base(covariant CompletionDateDto? value) =>
      RealmObjectBase.set(this, 'base', value);

  @override
  RealmList<String> get triggers =>
      RealmObjectBase.get<String>(this, 'triggers') as RealmList<String>;
  @override
  set triggers(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CompletionDateActionDto>> get changes =>
      RealmObjectBase.getChanges<CompletionDateActionDto>(this);

  @override
  CompletionDateActionDto freeze() =>
      RealmObjectBase.freezeObject<CompletionDateActionDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CompletionDateActionDto._);
    return const SchemaObject(ObjectType.realmObject, CompletionDateActionDto,
        'CompletionDateActionDto', [
      SchemaProperty('base', RealmPropertyType.object,
          optional: true, linkTarget: 'CompletionDateDto'),
      SchemaProperty('triggers', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class ActionHabitDto extends _ActionHabitDto
    with RealmEntity, RealmObjectBase, RealmObject {
  ActionHabitDto(
    String id,
    String name, {
    Iterable<String> triggers = const [],
    Iterable<CompletionDateActionDto> completionDates = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<String>>(
        this, 'triggers', RealmList<String>(triggers));
    RealmObjectBase.set<RealmList<CompletionDateActionDto>>(this,
        'completionDates', RealmList<CompletionDateActionDto>(completionDates));
  }

  ActionHabitDto._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<String> get triggers =>
      RealmObjectBase.get<String>(this, 'triggers') as RealmList<String>;
  @override
  set triggers(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<CompletionDateActionDto> get completionDates =>
      RealmObjectBase.get<CompletionDateActionDto>(this, 'completionDates')
          as RealmList<CompletionDateActionDto>;
  @override
  set completionDates(covariant RealmList<CompletionDateActionDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ActionHabitDto>> get changes =>
      RealmObjectBase.getChanges<ActionHabitDto>(this);

  @override
  ActionHabitDto freeze() => RealmObjectBase.freezeObject<ActionHabitDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ActionHabitDto._);
    return const SchemaObject(
        ObjectType.realmObject, ActionHabitDto, 'ActionHabitDto', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('triggers', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('completionDates', RealmPropertyType.object,
          linkTarget: 'CompletionDateActionDto',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class RewardDto extends _RewardDto
    with RealmEntity, RealmObjectBase, RealmObject {
  RewardDto(
    String id,
    String name, {
    Iterable<String> actions = const [],
    Iterable<CompletionDateRewardDto> completionDates = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<String>>(
        this, 'actions', RealmList<String>(actions));
    RealmObjectBase.set<RealmList<CompletionDateRewardDto>>(this,
        'completionDates', RealmList<CompletionDateRewardDto>(completionDates));
  }

  RewardDto._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<String> get actions =>
      RealmObjectBase.get<String>(this, 'actions') as RealmList<String>;
  @override
  set actions(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<CompletionDateRewardDto> get completionDates =>
      RealmObjectBase.get<CompletionDateRewardDto>(this, 'completionDates')
          as RealmList<CompletionDateRewardDto>;
  @override
  set completionDates(covariant RealmList<CompletionDateRewardDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RewardDto>> get changes =>
      RealmObjectBase.getChanges<RewardDto>(this);

  @override
  RewardDto freeze() => RealmObjectBase.freezeObject<RewardDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RewardDto._);
    return const SchemaObject(ObjectType.realmObject, RewardDto, 'RewardDto', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('actions', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('completionDates', RealmPropertyType.object,
          linkTarget: 'CompletionDateRewardDto',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class ProgressDto extends _ProgressDto
    with RealmEntity, RealmObjectBase, RealmObject {
  ProgressDto(
    String id,
    String imagePath,
    String description,
    int time,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'imagePath', imagePath);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'time', time);
  }

  ProgressDto._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get imagePath =>
      RealmObjectBase.get<String>(this, 'imagePath') as String;
  @override
  set imagePath(String value) => RealmObjectBase.set(this, 'imagePath', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  int get time => RealmObjectBase.get<int>(this, 'time') as int;
  @override
  set time(int value) => RealmObjectBase.set(this, 'time', value);

  @override
  Stream<RealmObjectChanges<ProgressDto>> get changes =>
      RealmObjectBase.getChanges<ProgressDto>(this);

  @override
  ProgressDto freeze() => RealmObjectBase.freezeObject<ProgressDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProgressDto._);
    return const SchemaObject(
        ObjectType.realmObject, ProgressDto, 'ProgressDto', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('imagePath', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('time', RealmPropertyType.int),
    ]);
  }
}

class HabitPlanDto extends _HabitPlanDto
    with RealmEntity, RealmObjectBase, RealmObject {
  HabitPlanDto(
    String id,
    String name,
    String description, {
    Iterable<String> gives = const [],
    Iterable<String> takes = const [],
    Iterable<ProgressDto> progress = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set<RealmList<String>>(
        this, 'gives', RealmList<String>(gives));
    RealmObjectBase.set<RealmList<String>>(
        this, 'takes', RealmList<String>(takes));
    RealmObjectBase.set<RealmList<ProgressDto>>(
        this, 'progress', RealmList<ProgressDto>(progress));
  }

  HabitPlanDto._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  RealmList<String> get gives =>
      RealmObjectBase.get<String>(this, 'gives') as RealmList<String>;
  @override
  set gives(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get takes =>
      RealmObjectBase.get<String>(this, 'takes') as RealmList<String>;
  @override
  set takes(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ProgressDto> get progress =>
      RealmObjectBase.get<ProgressDto>(this, 'progress')
          as RealmList<ProgressDto>;
  @override
  set progress(covariant RealmList<ProgressDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<HabitPlanDto>> get changes =>
      RealmObjectBase.getChanges<HabitPlanDto>(this);

  @override
  HabitPlanDto freeze() => RealmObjectBase.freezeObject<HabitPlanDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(HabitPlanDto._);
    return const SchemaObject(
        ObjectType.realmObject, HabitPlanDto, 'HabitPlanDto', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('gives', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('takes', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('progress', RealmPropertyType.object,
          linkTarget: 'ProgressDto', collectionType: RealmCollectionType.list),
    ]);
  }
}

class HabitDto extends _HabitDto
    with RealmEntity, RealmObjectBase, RealmObject {
  HabitDto(
    String id,
    String target,
    String description,
    double frequency,
    int duration,
    bool isCompleted, {
    String? imagePath,
    HabitPlanDto? plan,
    Iterable<int> time = const [],
    Iterable<TriggerDto> triggers = const [],
    Iterable<ActionHabitDto> actions = const [],
    Iterable<RewardDto> rewards = const [],
    Iterable<String> support = const [],
    Iterable<CompletionDateDto> completionDates = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'imagePath', imagePath);
    RealmObjectBase.set(this, 'target', target);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'frequency', frequency);
    RealmObjectBase.set(this, 'duration', duration);
    RealmObjectBase.set(this, 'plan', plan);
    RealmObjectBase.set(this, 'isCompleted', isCompleted);
    RealmObjectBase.set<RealmList<int>>(this, 'time', RealmList<int>(time));
    RealmObjectBase.set<RealmList<TriggerDto>>(
        this, 'triggers', RealmList<TriggerDto>(triggers));
    RealmObjectBase.set<RealmList<ActionHabitDto>>(
        this, 'actions', RealmList<ActionHabitDto>(actions));
    RealmObjectBase.set<RealmList<RewardDto>>(
        this, 'rewards', RealmList<RewardDto>(rewards));
    RealmObjectBase.set<RealmList<String>>(
        this, 'support', RealmList<String>(support));
    RealmObjectBase.set<RealmList<CompletionDateDto>>(
        this, 'completionDates', RealmList<CompletionDateDto>(completionDates));
  }

  HabitDto._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get imagePath =>
      RealmObjectBase.get<String>(this, 'imagePath') as String?;
  @override
  set imagePath(String? value) => RealmObjectBase.set(this, 'imagePath', value);

  @override
  String get target => RealmObjectBase.get<String>(this, 'target') as String;
  @override
  set target(String value) => RealmObjectBase.set(this, 'target', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  double get frequency =>
      RealmObjectBase.get<double>(this, 'frequency') as double;
  @override
  set frequency(double value) => RealmObjectBase.set(this, 'frequency', value);

  @override
  int get duration => RealmObjectBase.get<int>(this, 'duration') as int;
  @override
  set duration(int value) => RealmObjectBase.set(this, 'duration', value);

  @override
  RealmList<int> get time =>
      RealmObjectBase.get<int>(this, 'time') as RealmList<int>;
  @override
  set time(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  HabitPlanDto? get plan =>
      RealmObjectBase.get<HabitPlanDto>(this, 'plan') as HabitPlanDto?;
  @override
  set plan(covariant HabitPlanDto? value) =>
      RealmObjectBase.set(this, 'plan', value);

  @override
  RealmList<TriggerDto> get triggers =>
      RealmObjectBase.get<TriggerDto>(this, 'triggers')
          as RealmList<TriggerDto>;
  @override
  set triggers(covariant RealmList<TriggerDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ActionHabitDto> get actions =>
      RealmObjectBase.get<ActionHabitDto>(this, 'actions')
          as RealmList<ActionHabitDto>;
  @override
  set actions(covariant RealmList<ActionHabitDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<RewardDto> get rewards =>
      RealmObjectBase.get<RewardDto>(this, 'rewards') as RealmList<RewardDto>;
  @override
  set rewards(covariant RealmList<RewardDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get support =>
      RealmObjectBase.get<String>(this, 'support') as RealmList<String>;
  @override
  set support(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  bool get isCompleted =>
      RealmObjectBase.get<bool>(this, 'isCompleted') as bool;
  @override
  set isCompleted(bool value) =>
      RealmObjectBase.set(this, 'isCompleted', value);

  @override
  RealmList<CompletionDateDto> get completionDates =>
      RealmObjectBase.get<CompletionDateDto>(this, 'completionDates')
          as RealmList<CompletionDateDto>;
  @override
  set completionDates(covariant RealmList<CompletionDateDto> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<HabitDto>> get changes =>
      RealmObjectBase.getChanges<HabitDto>(this);

  @override
  HabitDto freeze() => RealmObjectBase.freezeObject<HabitDto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(HabitDto._);
    return const SchemaObject(ObjectType.realmObject, HabitDto, 'HabitDto', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('imagePath', RealmPropertyType.string, optional: true),
      SchemaProperty('target', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('frequency', RealmPropertyType.double),
      SchemaProperty('duration', RealmPropertyType.int),
      SchemaProperty('time', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
      SchemaProperty('plan', RealmPropertyType.object,
          optional: true, linkTarget: 'HabitPlanDto'),
      SchemaProperty('triggers', RealmPropertyType.object,
          linkTarget: 'TriggerDto', collectionType: RealmCollectionType.list),
      SchemaProperty('actions', RealmPropertyType.object,
          linkTarget: 'ActionHabitDto',
          collectionType: RealmCollectionType.list),
      SchemaProperty('rewards', RealmPropertyType.object,
          linkTarget: 'RewardDto', collectionType: RealmCollectionType.list),
      SchemaProperty('support', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('isCompleted', RealmPropertyType.bool),
      SchemaProperty('completionDates', RealmPropertyType.object,
          linkTarget: 'CompletionDateDto',
          collectionType: RealmCollectionType.list),
    ]);
  }
}
