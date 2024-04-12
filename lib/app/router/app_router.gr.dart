// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HabitAddRoute.name: (routeData) {
      final args = routeData.argsAs<HabitAddRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HabitAddScreen(
          key: args.key,
          onTap: args.onTap,
          habit: args.habit,
        ),
      );
    },
    HabitDetailRoute.name: (routeData) {
      final args = routeData.argsAs<HabitDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HabitDetailScreen(
          key: args.key,
          habit: args.habit,
        ),
      );
    },
    HabitsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HabitsScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    StatRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StatScreen(),
      );
    },
  };
}

/// generated route for
/// [HabitAddScreen]
class HabitAddRoute extends PageRouteInfo<HabitAddRouteArgs> {
  HabitAddRoute({
    Key? key,
    required dynamic Function(Habit) onTap,
    Habit? habit,
    List<PageRouteInfo>? children,
  }) : super(
          HabitAddRoute.name,
          args: HabitAddRouteArgs(
            key: key,
            onTap: onTap,
            habit: habit,
          ),
          initialChildren: children,
        );

  static const String name = 'HabitAddRoute';

  static const PageInfo<HabitAddRouteArgs> page =
      PageInfo<HabitAddRouteArgs>(name);
}

class HabitAddRouteArgs {
  const HabitAddRouteArgs({
    this.key,
    required this.onTap,
    this.habit,
  });

  final Key? key;

  final dynamic Function(Habit) onTap;

  final Habit? habit;

  @override
  String toString() {
    return 'HabitAddRouteArgs{key: $key, onTap: $onTap, habit: $habit}';
  }
}

/// generated route for
/// [HabitDetailScreen]
class HabitDetailRoute extends PageRouteInfo<HabitDetailRouteArgs> {
  HabitDetailRoute({
    Key? key,
    required Habit habit,
    List<PageRouteInfo>? children,
  }) : super(
          HabitDetailRoute.name,
          args: HabitDetailRouteArgs(
            key: key,
            habit: habit,
          ),
          initialChildren: children,
        );

  static const String name = 'HabitDetailRoute';

  static const PageInfo<HabitDetailRouteArgs> page =
      PageInfo<HabitDetailRouteArgs>(name);
}

class HabitDetailRouteArgs {
  const HabitDetailRouteArgs({
    this.key,
    required this.habit,
  });

  final Key? key;

  final Habit habit;

  @override
  String toString() {
    return 'HabitDetailRouteArgs{key: $key, habit: $habit}';
  }
}

/// generated route for
/// [HabitsScreen]
class HabitsRoute extends PageRouteInfo<void> {
  const HabitsRoute({List<PageRouteInfo>? children})
      : super(
          HabitsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HabitsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StatScreen]
class StatRoute extends PageRouteInfo<void> {
  const StatRoute({List<PageRouteInfo>? children})
      : super(
          StatRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
