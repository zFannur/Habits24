import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/app/theme/app_colors.dart';
import 'package:habits24/domain/domain.dart';

class WeekDaysCounterWidget extends StatefulWidget {
  final List<CompletionDate> completionDates;
  final void Function(DateTime date) onTap;

  const WeekDaysCounterWidget({
    super.key,
    required this.onTap,
    required this.completionDates,
  });

  @override
  WeekDaysCounterWidgetState createState() => WeekDaysCounterWidgetState();
}

class WeekDaysCounterWidgetState extends State<WeekDaysCounterWidget>
    with SingleTickerProviderStateMixin {
  late DateTime _firstDayOfCurrentWeek;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _animateToLeft =
      true; // Переменная для отслеживания направления анимации

  @override
  void initState() {
    super.initState();
    _firstDayOfCurrentWeek = _getFirstDayOfWeek(DateTime.now());
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  DateTime _getFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<DateTime> _getWeekDates(DateTime startOfWeek) {
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void _goToNextWeek() {
    setState(() {
      _animateToLeft = true; // Анимация направлена влево
      _firstDayOfCurrentWeek = _getFirstDayOfWeek(
          _firstDayOfCurrentWeek.add(const Duration(days: 7)));
    });
    _updateSlideAnimation();
    _animationController.forward(from: 0.0);
  }

  void _goToPreviousWeek() {
    setState(() {
      _animateToLeft = false; // Анимация направлена вправо
      _firstDayOfCurrentWeek = _getFirstDayOfWeek(
          _firstDayOfCurrentWeek.subtract(const Duration(days: 7)));
    });
    _updateSlideAnimation();
    _animationController.forward(from: 0.0);
  }

  void _updateSlideAnimation() {
    final offsetBegin =
        _animateToLeft ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
    _slideAnimation = Tween<Offset>(begin: offsetBegin, end: Offset.zero)
        .animate(_animationController);
  }

  Color _calculateColor(DateTime date) {
    final completionDate = widget.completionDates.where(
      (cd) =>
          cd.completionDate.year == date.year &&
          cd.completionDate.month == date.month &&
          cd.completionDate.day == date.day,
    );

    if (completionDate.isNotEmpty &&
        completionDate.first.completionFrequency > 0) {
      return AppColors.orange;
    }

    return AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates(_firstDayOfCurrentWeek);
    // Определение направления анимации на основе действия пользователя
    // final offsetBegin = _animateToLeft ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
    // const offsetEnd = Offset.zero;
    // // Обновляем анимацию с новыми значениями
    // _slideAnimation = Tween<Offset>(begin: offsetBegin, end: offsetEnd).animate(_animationController);

    return Padding(
      padding: AppPadding.vertical8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              _goToPreviousWeek();
              _animationController.forward(from: 0.0); // Запуск анимации
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.orange,
            ),
          ),
          GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0) {
                _goToPreviousWeek();
                _animationController.forward(from: 0.0); // Запуск анимации
              } else if (details.primaryVelocity! < 0) {
                _goToNextWeek();
                _animationController.forward(from: 0.0); // Запуск анимации
              }
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: _slideAnimation,
                  child: child,
                );
              },
              child: Row(
                key: ValueKey<DateTime>(_firstDayOfCurrentWeek),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  7,
                  (index) {
                    final date = weekDates[index];
                    return InkWell(
                      onTap: () => widget.onTap.call(date),
                      child: Container(
                        margin: AppPadding.horizontal2,
                        padding: AppPadding.all8,
                        decoration: BoxDecoration(
                          color: _calculateColor(date),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppConst.weekList[date.weekday - 1],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              "${date.day}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              "${widget.completionDates.where((cd) => cd.completionDate.year == date.year && cd.completionDate.month == date.month && cd.completionDate.day == date.day).isNotEmpty ? widget.completionDates.firstWhere((cd) => cd.completionDate.year == date.year && cd.completionDate.month == date.month && cd.completionDate.day == date.day).completionFrequency : ''}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
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
          IconButton(
            onPressed: () {
              _goToNextWeek();
              _animationController.forward(from: 0.0); // Запуск анимации
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
