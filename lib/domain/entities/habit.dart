class CompletionDate {
  final String id;
  final int completionFrequency;
  final DateTime completionDate;

  CompletionDate({
    required this.id,
    required this.completionFrequency,
    required this.completionDate,
  });

  CompletionDate copyWith({
    String? id,
    int? completionFrequency,
    DateTime? completionDate,
  }) {
    return CompletionDate(
      id: id ?? this.id,
      completionFrequency: completionFrequency ?? this.completionFrequency,
      completionDate: completionDate ?? this.completionDate,
    );
  }
}

class CompletionDateReward extends CompletionDate {
  final List<String> words;
  final List<String> actions;

  CompletionDateReward({
    required this.actions,
    required this.words,
    required super.id,
    required super.completionFrequency,
    required super.completionDate,
  });

  @override
  CompletionDateReward copyWith({
    String? id,
    int? completionFrequency,
    DateTime? completionDate,
    List<String>? words,
    List<String>? actions,
  }) {
    return CompletionDateReward(
      id: id ?? this.id,
      actions: actions ?? this.actions,
      completionFrequency: completionFrequency ?? this.completionFrequency,
      completionDate: completionDate ?? this.completionDate,
      words: words ?? this.words,
    );
  }
}

class CompletionDateTrigger extends CompletionDate {
  final TriggerQuestion triggerQuestion;

  CompletionDateTrigger({
    required this.triggerQuestion,
    required super.id,
    required super.completionFrequency,
    required super.completionDate,
  });

  @override
  CompletionDateTrigger copyWith({
    String? id,
    int? completionFrequency,
    DateTime? completionDate,
    TriggerQuestion? triggerQuestion,
  }) {
    return CompletionDateTrigger(
      id: id ?? this.id,
      completionFrequency: completionFrequency ?? this.completionFrequency,
      completionDate: completionDate ?? this.completionDate,
      triggerQuestion: triggerQuestion ?? this.triggerQuestion,
    );
  }
}

class CompletionDateAction extends CompletionDate {
  final List<String> triggers;

  CompletionDateAction({
    required this.triggers,
    required super.id,
    required super.completionFrequency,
    required super.completionDate,
  });

  @override
  CompletionDateAction copyWith({
    String? id,
    int? completionFrequency,
    DateTime? completionDate,
    List<String>? triggers,
  }) {
    return CompletionDateAction(
      id: id ?? this.id,
      completionFrequency: completionFrequency ?? this.completionFrequency,
      completionDate: completionDate ?? this.completionDate,
      triggers: triggers ?? this.triggers,
    );
  }
}

class TriggerQuestion {
  final String location;
  final String time;
  final String emotionalState;
  final String otherPeople;
  final String priorAction;

  TriggerQuestion({
    required this.location,
    required this.time,
    required this.emotionalState,
    required this.otherPeople,
    required this.priorAction,
  });
}

class Trigger {
  final String id;
  final String name;
  final List<CompletionDateTrigger> completionDates;

  Trigger({
    required this.id,
    required this.name,
    required this.completionDates,
  });

  Trigger copyWith({
    String? id,
    String? name,
    List<CompletionDateTrigger>? completionDates,
  }) {
    return Trigger(
      id: id ?? this.id,
      name: name ?? this.name,
      completionDates: completionDates ?? this.completionDates,
    );
  }
}

class ActionHabit {
  final String id;
  final String name;
  final List<CompletionDateAction> completionDates;

  ActionHabit({
    required this.id,
    required this.name,
    required this.completionDates,
  });

  ActionHabit copyWith({
    String? id,
    String? name,
    List<String>? triggers,
    List<CompletionDateAction>? completionDates,
  }) {
    return ActionHabit(
      id: id ?? this.id,
      name: name ?? this.name,
      completionDates: completionDates ?? this.completionDates,
    );
  }
}

class Reward {
  final String id;
  final String name;
  final List<String> actions;
  final List<CompletionDateReward> completionDates;

  Reward({
    required this.actions,
    required this.id,
    required this.name,
    required this.completionDates,
  });

  Reward copyWith({
    String? id,
    String? name,
    List<String>? actions,
    List<CompletionDateReward>? completionDates,
  }) {
    return Reward(
      id: id ?? this.id,
      name: name ?? this.name,
      actions: actions ?? this.actions,
      completionDates: completionDates ?? this.completionDates,
    );
  }
}

class Progress {
  final String id;
  final String imagePath;
  final String description;
  final DateTime time;

  Progress({
    required this.time,
    required this.id,
    required this.imagePath,
    required this.description,
  });

  Progress copyWith({
    String? id,
    String? imagePath,
    String? description,
    DateTime? time,
  }) {
    return Progress(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }
}

class HabitPlan {
  final String id;
  final String name;
  final String description;
  final List<String> gives; // что дает привычка
  final List<String> takes; // что забирает привычка
  final List<Progress> progress; // прогресс по привычке

  HabitPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.gives,
    required this.takes,
    required this.progress,
  });

  HabitPlan copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? gives,
    List<String>? takes,
    List<Progress>? progress,
  }) {
    return HabitPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      gives: gives ?? this.gives,
      takes: takes ?? this.takes,
      progress: progress ?? this.progress,
    );
  }
}

class Habit {
  final String id;

  // цель и описание
  final String? imagePath; // путь к изображению
  final String target; // название
  final String description; // описание
  final double frequency; // Частота выполнения привычки
  final int duration; // Продолжительность выполнения привычки
  final List<DateTime> time; //время для выполнения

  // мотивация и прогресс
  final HabitPlan? plan;

  // анализ
  final List<Trigger> triggers; // Список триггеров привычки
  final List<ActionHabit> actions; // Список рутины привычки
  final List<Reward> rewards; // Список наград привычки

  final List<String> support; // кто поддержет при сбоях

  // данные для отслеживания прогресса
  final bool isCompleted; // завершена ли привычка
  final List<CompletionDate>
      completionDates; // Список дат, когда привычка была выполнена

  Habit({
    this.imagePath,
    required this.id,
    required this.target,
    required this.description,
    required this.frequency,
    required this.duration,
    required this.time,
    this.plan,
    required this.triggers,
    required this.actions,
    required this.rewards,
    required this.support,
    required this.isCompleted,
    required this.completionDates,
  });

  Habit copyWith({
    String? imagePath,
    String? id,
    String? target,
    String? description,
    double? frequency,
    int? duration,
    List<DateTime>? time,
    HabitPlan? plan,
    List<Trigger>? triggers,
    List<ActionHabit>? actions,
    List<Reward>? rewards,
    List<String>? support,
    bool? isCompleted,
    List<CompletionDate>? completionDates,
  }) {
    return Habit(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      target: target ?? this.target,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      time: time ?? this.time,
      plan: plan ?? this.plan,
      triggers: triggers ?? this.triggers,
      actions: actions ?? this.actions,
      rewards: rewards ?? this.rewards,
      support: support ?? this.support,
      isCompleted: isCompleted ?? this.isCompleted,
      completionDates: completionDates ?? this.completionDates,
    );
  }
}
