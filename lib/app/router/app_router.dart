import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/ui/features/habits/habits.dart';
import 'package:habits24/ui/features/habits/screens/habit_add_screen.dart';
import 'package:habits24/ui/features/home/home.dart';
import 'package:habits24/ui/features/settings/screens/screens.dart';
import 'package:habits24/ui/features/stat/stat.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(
          page: HabitsRoute.page,
          path: 'habits',
        ),
        AutoRoute(
          page: StatRoute.page,
          path: 'stat',
        ),
        // AutoRoute(
        //   page: FinanceStatisticRoute.page,
        //   path: 'finance_statistic',
        // ),
      ],
    ),

    AutoRoute(
      page: HabitAddRoute.page,
      path: '/add',
    ),
    AutoRoute(
      page: HabitDetailRoute.page,
      path: '/detail',
    ),
    AutoRoute(
      page: SettingsRoute.page,
      path: '/settings',
    ),
    // AutoRoute(
    //   page: CategoriesEditRoute.page,
    //   path: '/categories',
    // ),
  ];
}