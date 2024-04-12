import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/app/app_bloc_observer.dart';
import 'package:habits24/data/data.dart';
import 'package:realm/realm.dart';

import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // для генерации парсера flutter pub run easy_localization:generate -S "assets/translations" -O "lib/generated"
  // для генерации ключей flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S "assets/translations" -O "lib/generated"
  await EasyLocalization.ensureInitialized();

  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: foundation.kIsWeb
  //       ? HydratedStorage.webStorageDirectory
  //       : await getApplicationDocumentsDirectory(),
  // );


  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  Bloc.observer = const AppBlocObserver();

  final config = Configuration.local(
    [
      CompletionDateDto.schema,
      CompletionDateRewardDto.schema,
      TriggerQuestionDto.schema,
      TriggerDto.schema,
      CompletionDateTriggerDto.schema,
      CompletionDateActionDto.schema,
      ActionHabitDto.schema,
      RewardDto.schema,
      ProgressDto.schema,
      HabitPlanDto.schema,
      HabitDto.schema,
    ],
    schemaVersion: 7,
  );

  final realm = Realm(config);

  final habitsLocalStorage = RealmHabitsLocalStorage(realm);

  final habitsRepository = HabitsRepository(habitsLocalStorage);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: habitsRepository,
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [AppLocale.enUS, AppLocale.ruRU],
        path: 'assets/translations',
        fallbackLocale: AppLocale.ruRU,
        assetLoader: const CodegenLoader(),
        child: Habits24App(savedThemeMode: savedThemeMode),
      ),
    ),
  );
}
