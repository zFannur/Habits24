import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/ui/features/habits/habits.dart';
import 'package:uuid/v4.dart';

@RoutePage()
class HabitAddScreen extends StatefulWidget {
  final Function(Habit habitEntity) onTap;
  final Habit? habit;

  const HabitAddScreen({
    super.key,
    required this.onTap,
    this.habit,
  });

  @override
  State<HabitAddScreen> createState() => _HabitAddScreenState();
}

class _HabitAddScreenState extends State<HabitAddScreen> {
  final formKey = GlobalKey<FormState>();

  final controllerTarget = TextEditingController();
  final controllerDescription = TextEditingController();
  late int frequency;
  late int duration;
  late List<DateTime> time;
  late String id;

  final controllerGives = TextEditingController();
  final controllerTakes = TextEditingController();

  final controllerTrigger = TextEditingController();
  late List<Trigger> triggersList;
  late List<String> triggersListName;
  final controllerAction = TextEditingController();
  late List<ActionHabit> actionsList;
  final controllerReward = TextEditingController();
  late List<Reward> rewardsList;
  final controllerSupport = TextEditingController();
  late List<String> supportsList;
  late String imagePath;

  @override
  void initState() {
    time = widget.habit?.time ?? [];
    frequency = widget.habit?.frequency.toInt() ?? 0;
    duration = widget.habit?.duration ?? 21;

    triggersListName = widget.habit?.triggers.map((e) => e.name).toList() ?? [];

    triggersList = widget.habit?.triggers ?? [];
    actionsList = widget.habit?.actions ?? [];
    rewardsList = widget.habit?.rewards ?? [];
    supportsList = widget.habit?.support ?? [];

    imagePath = widget.habit?.imagePath ?? '';
    id = widget.habit?.id ?? const UuidV4().generate();

    if (widget.habit != null) {
      controllerTarget.text = widget.habit?.target ?? "";
      controllerDescription.text = widget.habit?.description ?? "";
    }

    super.initState();
  }

  @override
  void dispose() {
    controllerTarget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        name: widget.habit != null ? 'Редактировать' : 'Добавить',
        withArrowBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: AppPadding.v8h20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditableImageWidget(
                      height: 200,
                      width: double.infinity,
                      imagePath: imagePath,
                      editable: true,
                      onAdd: (imagePath) {
                        this.imagePath = imagePath;
                        setState(() {});
                      },
                      onDelete: () {
                        imagePath = '';
                        setState(() {});
                      },
                    ),
                    CustomTextField(
                      controller: controllerTarget,
                      labelText: 'Назовите привычку *',
                      name: 'Название *',
                      validator: emptyValidator,
                    ),
                    CustomTextField(
                      controller: controllerDescription,
                      labelText: 'Краткая мотивация',
                      name: 'Описание *',
                      validator: emptyValidator,
                    ),
                    Padding(
                      padding: AppPadding.top8,
                      child: CounterWidget(
                        name: 'Повторов в день',
                        countNum: frequency,
                        onTapAdd: () {
                          frequency++;
                          setState(() {});
                        },
                        onTapRemove: () {
                          if (frequency <= 0) return;
                          frequency--;
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: AppPadding.top8,
                      child: CounterWidget(
                        name: 'Продолжительность',
                        countNum: duration,
                        onTapAdd: () {
                          duration++;
                          setState(() {});
                        },
                        onTapRemove: () {
                          if (duration <= 0) return;
                          duration--;
                          setState(() {});
                        },
                      ),
                    ),
                    // выбор времени

                    CustomTextFieldWithList(
                      controller: controllerTrigger,
                      labelText: 'После привычка выполняется *',
                      name: 'Триггеры *',
                      list: triggersList.map((e) => e.name).toList(),
                      onAdd: () {
                        final newTrigger = Trigger(
                          id: const UuidV4().generate(),
                          name: controllerTrigger.text,
                          completionDates: [],
                        );
                        triggersList.add(newTrigger);
                        controllerTrigger.clear();
                        setState(() {});
                      },
                      onDelete: (text) {
                        triggersList
                            .removeWhere((trigger) => trigger.name == text);
                        setState(() {});
                      },
                    ),
                    CustomTextFieldWithList(
                      controller: controllerAction,
                      labelText: 'Какое действие выполняется *',
                      name: 'Действие *',
                      list: actionsList.map((e) => e.name).toList(),
                      onAdd: () {
                        final newAction = ActionHabit(
                          id: const UuidV4().generate(),
                          name: controllerAction.text,
                          completionDates: [],
                        );
                        actionsList.add(newAction);
                        controllerAction.clear();
                        setState(() {});
                      },
                      onDelete: (text) {
                        actionsList
                            .removeWhere((action) => action.name == text);
                        setState(() {});
                      },
                    ),
                    CustomTextFieldWithList(
                      controller: controllerReward,
                      labelText: 'Награда после выполнения *',
                      name: 'Награда *',
                      list: rewardsList.map((e) => e.name).toList(),
                      onAdd: () {
                        final newReward = Reward(
                          id: const UuidV4().generate(),
                          name: controllerReward.text,
                          completionDates: [],
                          actions: [],
                        );
                        rewardsList.add(newReward);
                        controllerReward.clear();
                        setState(() {});
                      },
                      onDelete: (text) {
                        rewardsList
                            .removeWhere((reward) => reward.name == text);
                        setState(() {});
                      },
                    ),
                    CustomTextFieldWithList(
                      controller: controllerSupport,
                      labelText: 'Кто меня поддерживает',
                      name: 'Поддержка',
                      list: supportsList,
                      onAdd: () {
                        supportsList.add(controllerSupport.text);
                        controllerSupport.clear();
                      },
                      onDelete: (text) {
                        supportsList.remove(text);
                      },
                    ),

                    //Напоминание
                    NotificationsAddSection(
                      dateTimeList: time,
                      id: id.hashCode,
                      description: controllerDescription.text,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton(
                    onPressed: () {
                      context
                          .read<HabitsBloc>()
                          .add(HabitDeleted(widget.habit!));
                      context.maybePop();
                    },
                    child: const Text(
                      'Удалить',
                      style: AppTextStyle.medium14,
                    )),
                AppButton(
                    isFixedSize: false,
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        widget.onTap(Habit(
                          id: id,
                          imagePath: imagePath,
                          target: controllerTarget.text,
                          description: controllerDescription.text,
                          frequency: frequency.toDouble(),
                          duration: duration,
                          time: time,
                          triggers: triggersList,
                          actions: actionsList,
                          rewards: rewardsList,
                          support: supportsList,
                          isCompleted: false,
                          completionDates: widget.habit?.completionDates ?? [],
                          plan: widget.habit?.plan,
                        ));
                      }
                    },
                    child: Text(
                      widget.habit != null ? 'Редактировать' : 'Добавить',
                      style: AppTextStyle.medium14,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return "обязательное поле";
    }
    return null;
  }
}

class NotificationsAddSection extends StatefulWidget {
  const NotificationsAddSection(
      {super.key,
      required this.dateTimeList,
      required this.id,
      required this.description});

  final List<DateTime> dateTimeList;
  final int id;
  final String description;

  @override
  State<NotificationsAddSection> createState() =>
      _NotificationsAddSectionState();
}

class _NotificationsAddSectionState extends State<NotificationsAddSection> {
  TimeOfDay? _selectedTime;

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  DateTime combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: AppPadding.top8,
              child: Text(
                'Напоминание',
                style: AppTextStyle.bold24,
              ),
            ),
            IconButton(
              onPressed: () async {
                final habitBloc = context.read<HabitsBloc>();
                await _pickTime(context);
                if (_selectedTime != null) {
                  final currentDate = DateTime.now();
                  DateTime combinedDateTime =
                      combine(currentDate, _selectedTime!);

                  widget.dateTimeList.add(combinedDateTime);
                  habitBloc.add(HabitNotificationAdded(
                    combinedDateTime,
                    widget.id,
                    widget.description,
                  ));
                  setState(() {});
                }
              },
              icon: AppIcons.add,
            ),
          ],
        ),
        Wrap(
          children: List.generate(
            widget.dateTimeList.length,
            (index) {
              final format = DateFormat('HH:mm');
              final dateTime = widget.dateTimeList[index];

              return Row(
                children: [
                  Text(
                    format.format(dateTime),
                    style: AppTextStyle.medium20,
                  ),
                  IconButton(
                    onPressed: () {
                      final habitBloc = context.read<HabitsBloc>();
                      widget.dateTimeList.remove(dateTime);
                      habitBloc.add(HabitNotificationCanceled(
                        widget.id,
                      ));
                      setState(() {});
                    },
                    icon: AppIcons.delete,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class CounterWidget extends StatelessWidget {
  final String name;
  final int countNum;
  final Function() onTapAdd;
  final Function() onTapRemove;

  const CounterWidget({
    super.key,
    required this.countNum,
    required this.onTapAdd,
    required this.onTapRemove,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: AppTextStyle.bold24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onTapAdd,
              icon: const Icon(
                Icons.add,
                color: AppColors.orange,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.greyDark,
                shape: const RoundedRectangleBorder(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: AppColors.greyDark,
              padding: AppPadding.v8h20,
              child: Text(
                '$countNum',
                style: AppTextStyle.bold24,
              ),
            ),
            IconButton(
              onPressed: onTapRemove,
              icon: const Icon(
                Icons.remove,
                color: AppColors.orange,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.greyDark,
                shape: const RoundedRectangleBorder(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
