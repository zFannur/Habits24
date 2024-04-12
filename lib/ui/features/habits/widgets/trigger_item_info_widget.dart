import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';

class TriggerItemInfoWidget extends StatelessWidget {
  const TriggerItemInfoWidget({super.key, required this.completionDateTrigger});

  final List<CompletionDateTrigger> completionDateTrigger;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd.MM.yyyy');

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: List.generate(completionDateTrigger.length, (index) {
              final completionDate = completionDateTrigger[index];
              return Container(
                margin: AppPadding.top8,
                padding: AppPadding.v8h20,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Дата: ${format.format(completionDate.completionDate)}',
                                  style: AppTextStyle.bold14,
                                ),
                                Text(
                                  'Повторов: ${completionDate.completionFrequency}',
                                  style: AppTextStyle.bold14,
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Локация: ${completionDate.triggerQuestion.location}',
                              style: AppTextStyle.bold10,
                              overflow: TextOverflow.clip,
                            ),
                            const Divider(),
                            Text(
                              'Время: ${completionDate.triggerQuestion.time}',
                              style: AppTextStyle.bold10,
                              overflow: TextOverflow.clip,
                            ),
                            const Divider(),
                            Text(
                              'Эмоциональное состояние: ${completionDate.triggerQuestion.emotionalState}',
                              style: AppTextStyle.bold10,
                              overflow: TextOverflow.clip,
                            ),
                            const Divider(),
                            Text(
                              'Другие люди: ${completionDate.triggerQuestion.otherPeople}',
                              style: AppTextStyle.bold10,
                              overflow: TextOverflow.clip,
                            ),
                            const Divider(),
                            Text(
                              'Предшествующее действие: ${completionDate.triggerQuestion.priorAction}',
                              style: AppTextStyle.bold10,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        )),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}