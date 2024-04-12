import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/data/data.dart';
import 'package:habits24/ui/features/habits/habits.dart';
import 'package:habits24/ui/features/settings/settings.dart';

class Habits24App extends StatelessWidget {
  Habits24App({
    super.key,
    this.savedThemeMode,
  });

  final AdaptiveThemeMode? savedThemeMode;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocsLoader(
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        buildWhen: (previous, current) => previous.locale != current.locale,
        builder: (context, state) {
          return AdaptiveTheme(
            light: AppTheme.lightTheme,
            dark: AppTheme.darkTheme,
            initial: savedThemeMode ?? AdaptiveThemeMode.dark,
            builder: (theme, darkTheme) => MaterialApp.router(
              key: UniqueKey(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: state.locale,
              darkTheme: darkTheme,
              theme: theme,
              debugShowCheckedModeBanner: false,
              routerConfig: _appRouter.config(),
            ),
          );
        },
      ),
    );
  }
}

class BlocsLoader extends StatelessWidget {
  const BlocsLoader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HabitsBloc(
            habitsRepository: context.read<HabitsRepository>(),
          )..add(const HabitsSubscriptionRequested()),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(
            habitsRepository: context.read<HabitsRepository>(),
          ),
        ),
        // BlocProvider(
        //   create: (context) => PlanBloc(
        //     plansRepository: context.read<PlansRepository>(),
        //     operationsRepository: context.read<OperationsRepository>(),
        //   )
        //     ..add(const PlanSubscriptionRequested())
        //     ..add(const OperationsSubscriptionRequested()),
        // ),
        // BlocProvider(
        //   create: (context) => CategoriesCubit(
        //     categoriesRepository: context.read<RealmRepository<Category>>(),
        //     subCategoriesRepository:
        //         context.read<RealmRepository<SubCategory>>(),
        //   )..getAllCategories(),
        // ),
        BlocProvider(
          create: (context) => LocalizationCubit(),
        ),
        BlocProvider(
          create: (context) => RecommendationsCubit(),
        ),
      ],
      child: child,
    );
  }
}
