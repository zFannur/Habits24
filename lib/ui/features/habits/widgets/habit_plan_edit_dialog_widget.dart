import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/domain/entities/entities.dart';
import 'package:habits24/generated/locale_keys.g.dart';
import 'package:habits24/ui/features/habits/habits.dart';
import 'package:uuid/v4.dart';

class HabitPlanEditDialogWidget extends StatefulWidget {
  final HabitPlan? habitPlan;
  final Function(HabitPlan habitPlan)? onTap;

  const HabitPlanEditDialogWidget({
    super.key,
    required this.habitPlan,
    this.onTap,
  });

  @override
  State<HabitPlanEditDialogWidget> createState() =>
      _HabitPlanEditDialogWidgetState();
}

class _HabitPlanEditDialogWidgetState extends State<HabitPlanEditDialogWidget> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerGives = TextEditingController();
  final TextEditingController controllerTakes = TextEditingController();
  List<String> gives = [];
  List<String> takes = [];

  @override
  void initState() {
    final plan = widget.habitPlan;
    gives = plan?.gives ?? [];
    takes = plan?.takes ?? [];
    controllerName.text = plan?.name ?? '';
    controllerDescription.text = plan?.description ?? '';
    super.initState();
  }

  void _onAddGive(String value) {
    if (value.isNotEmpty) {
      setState(() {
        gives.add(value);
      });
      controllerGives.clear();
    }
  }

  void _onAddTake(String value) {
    if (value.isNotEmpty) {
      setState(() {
        takes.add(value);
      });
      controllerTakes.clear();
    }
  }

  void _onDeleteGive(String value) {
    setState(() {
      gives.remove(value);
    });
  }

  void _onDeleteTake(String value) {
    setState(() {
      takes.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPlanAvailable = widget.habitPlan != null;
    return AppDialogWidget(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.back.tr(),
                  style: theme.textTheme.titleMedium),
            ),
            TextButton(
              onPressed: () {
                if (isPlanAvailable) {
                  widget.onTap?.call(widget.habitPlan!.copyWith(
                    takes: takes,
                    gives: gives,
                    description: controllerDescription.text,
                    name: controllerName.text,
                  ));
                } else {
                  widget.onTap?.call(HabitPlan(
                    id: const UuidV4().generate(),
                    takes: takes,
                    gives: gives,
                    description: controllerDescription.text,
                    name: controllerName.text,
                    progress: [],
                  ));
                }
              },
              child: Text(
                  isPlanAvailable ? LocaleKeys.edit.tr() : LocaleKeys.add.tr(),
                  style: theme.textTheme.titleMedium),
            ),
          ],
        ),
      ],
      title: widget.habitPlan?.name ?? 'Нет плана',
      child: SizedBox(
        height: 400,
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTextField(
                labelText: 'Название',
                controller: controllerName,
              ),
              AppTextField(
                labelText: 'Описание',
                controller: controllerDescription,
                maxLines: 2,
              ),
              CustomTextFieldWithList(
                controller: controllerGives,
                labelText: 'Что дает',
                list: gives,
                onAdd: () => _onAddGive(controllerGives.text),
                onDelete: (value) => _onDeleteGive(value),
              ),
              CustomTextFieldWithList(
                controller: controllerTakes,
                labelText: 'Что забирает',
                list: takes,
                onAdd: () => _onAddTake(controllerTakes.text),
                onDelete: (value) => _onDeleteTake(value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllerDescription.dispose();
    controllerGives.dispose();
    controllerTakes.dispose();
    super.dispose();
  }
}
