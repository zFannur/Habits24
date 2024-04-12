import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/ui/features/habits/habits.dart';

class HabitSection extends StatelessWidget {
  final List<dynamic>
      items; // Убедитесь, что элементы соответствуют ожидаемому типу
  final Function onTapDate;
  final Function onTapItem;

  const HabitSection({
    super.key,
    required this.items,
    required this.onTapDate,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: AppPadding.horizontal16,
        //   child: Text(
        //     title,
        //     style: AppTextStyle.bold24,
        //   ),
        // ),
        ...items.map(
          (item) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppPadding.horizontal16,
                child: InkWell(
                  onTap: () => onTapItem(item),
                  child: Container(
                    width: double.infinity,
                    padding: AppPadding.v8h20,
                    decoration: const BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      item.name,
                      style: AppTextStyle.medium20
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: AppPadding.horizontal16,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: WeekDaysCounterWidget(
                    onTap: (DateTime date) => onTapDate(item, date),
                    completionDates: item.completionDates,
                  ),
                ),
              ),
              // WeekDaysCounterWidget(
              //   onTap: (DateTime date) => onTapDate(item, date),
              //   completionDates: item.completionDates,
              // ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
