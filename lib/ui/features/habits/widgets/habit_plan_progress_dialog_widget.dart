import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/generated/locale_keys.g.dart';
import 'package:habits24/ui/features/habits/habits.dart';
import 'package:uuid/v4.dart';

class HabitPlanProgressDialogWidget extends StatefulWidget {
  final HabitPlan? habitPlan;
  final Function(HabitPlan habitPlan)? onTap;

  const HabitPlanProgressDialogWidget({
    super.key,
    required this.habitPlan,
    this.onTap,
  });

  @override
  State<HabitPlanProgressDialogWidget> createState() =>
      _HabitPlanEditDialogWidgetState();
}

class _HabitPlanEditDialogWidgetState
    extends State<HabitPlanProgressDialogWidget> {
  final TextEditingController controllerDescription = TextEditingController();
  late List<Progress> progress;
  late String imagePath = '';

  @override
  void initState() {
    progress = widget.habitPlan?.progress ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                if (widget.habitPlan != null) {
                  progress.add(Progress(
                    id: const UuidV4().generate(),
                    imagePath: imagePath,
                    description: controllerDescription.text,
                    time: DateTime.now(),
                  ));
                  widget.onTap?.call(widget.habitPlan!.copyWith(
                    progress: progress,
                  ));
                }
              },
              child:
                  Text(LocaleKeys.add.tr(), style: theme.textTheme.titleMedium),
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
              EditableImageWidget(
                width: double.infinity,
                height: 200,
                editable: true,
                imagePath: imagePath,
                onAdd: (imagePath) {
                  this.imagePath = imagePath;
                  setState(() {});
                },
                onDelete: () {
                  imagePath = '';
                  setState(() {});
                },
              ),
              AppTextField(
                labelText: 'Описание',
                controller: controllerDescription,
                maxLines: 6,
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
    super.dispose();
  }
}
