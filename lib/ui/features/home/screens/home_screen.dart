import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/generated/locale_keys.g.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HabitsRoute(),
        StatRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppAppBar(
            name: LocaleKeys.experience.tr(),
            withSettings: true,
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.receipt_long, size: 0),
                label: LocaleKeys.habits.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.stacked_line_chart, size: 0),
                label: LocaleKeys.stat.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
