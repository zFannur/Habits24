import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/ui/features/habits/habits.dart';

class WeekDaysWidget extends StatefulWidget {
  final Habit habit;

  const WeekDaysWidget({super.key, required this.habit});

  @override
  State<WeekDaysWidget> createState() => _WeekDaysWidgetState();
}

class _WeekDaysWidgetState extends State<WeekDaysWidget> {
  late DateTime _firstDayOfCurrentWeek;

  @override
  void initState() {
    super.initState();
    _firstDayOfCurrentWeek = _getFirstDayOfWeek(DateTime.now());
  }

  DateTime _getFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<DateTime> _getWeekDates() {
    return List.generate(
        7, (index) => _firstDayOfCurrentWeek.add(Duration(days: index)));
  }

  void _goToNextWeek() {
    setState(() {
      _firstDayOfCurrentWeek = _getFirstDayOfWeek(_firstDayOfCurrentWeek.add(Duration(days: 7)));
    });
  }

  void _goToPreviousWeek() {
    setState(() {
      _firstDayOfCurrentWeek = _getFirstDayOfWeek(_firstDayOfCurrentWeek.subtract(Duration(days: 7)));
    });
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  Color _calculateColor(DateTime date) {
    final completionDate = widget.habit.completionDates.where(
          (cd) =>
      cd.completionDate.year == date.year &&
          cd.completionDate.month == date.month &&
          cd.completionDate.day == date.day,
    );

    if (completionDate.isNotEmpty &&
        widget.habit.frequency > 0 &&
        completionDate.first.completionFrequency > 0) {
      final alpha = 255 ~/ widget.habit.frequency;
      int effectiveAlpha = completionDate.first.completionFrequency * alpha;
      if (effectiveAlpha > 255) {
        effectiveAlpha = 255;
      }
      if (_isToday(date)) {
        return AppColors.green.withAlpha(effectiveAlpha);
      }

      return AppColors.orange.withAlpha(effectiveAlpha);
    }

    if (_isToday(date)) {
      return AppColors.red;
    }

    return AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates();

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          _goToPreviousWeek();
        } else if (details.primaryVelocity! < 0) {
          _goToNextWeek();
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: Padding(
          key: ValueKey<DateTime>(_firstDayOfCurrentWeek),
          padding: const EdgeInsets.only(top: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              7,
                  (index) {
                final date = weekDates[index];

                return InkWell(
                  onTap: () {
                    context.read<HabitsBloc>().add(HabitMarked(widget.habit, date));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _calculateColor(date),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppConst.weekList[date.weekday - 1],
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        Text(
                          "${date.day}",
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
