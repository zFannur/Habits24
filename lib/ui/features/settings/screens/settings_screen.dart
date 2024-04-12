import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/entities/error_entity.dart';
import 'package:habits24/generated/locale_keys.g.dart';
import 'package:habits24/ui/features/settings/settings.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    //final route = context.router;
    return Scaffold(
      appBar: AppAppBar(
        name: LocaleKeys.settings.tr(),
        withSettings: false,
        withArrowBack: true,
      ),
      body: Center(
        child: Column(
          children: [
            SettingsItem(
              name: LocaleKeys.saved_files.tr(),
              onTap: () async {
                // final navigator = Navigator.of(context);
                // settingsCubit.getSavedVariables();
                // context.read<SettingsCubit>().getSavedExcelFiles();
                // await navigator.push(
                //   MaterialPageRoute<PreloadDataScreen>(
                //     builder: (context) => const PreloadSavedFilesScreen(),
                //   ),
                // );
              },
            ),
            BlocConsumer<SettingsCubit, SettingsState>(
              listener: (context, state) {
                if (state.asyncSnapshot?.hasData == true) {
                  AppSnackBar.showSnackBarWithMessage(
                    context,
                    state.asyncSnapshot?.data,
                  );
                }

                if (state.asyncSnapshot?.hasError == true) {
                  AppSnackBar.showSnackBarWithError(
                    context,
                    ErrorEntity(message: state.asyncSnapshot!.error.toString()),
                  );
                }
              },
              builder: (context, state) {
                bool isWaiting = state.asyncSnapshot?.connectionState ==
                    ConnectionState.waiting;

                return SettingsItem(
                  name: LocaleKeys.load_data.tr(),
                  onTap: () async {
                    //final navigator = Navigator.of(context);
                    // final excelSheet =
                    //     await context.read<SettingsCubit>().importFromExcel();
                    // await navigator.push(
                    //   MaterialPageRoute<PreloadDataScreen>(
                    //     builder: (context) => PreloadDataScreen(
                    //       excelSheet: excelSheet,
                    //     ),
                    //   ),
                    //);
                  },
                  widget: isWaiting ? const AppLoader(withText: false) : null,
                );
              },
            ),
            SettingsItem(
              name: LocaleKeys.lang.tr(),
              widget: AppDropdownButtonWidget<Locale>(
                  value: context.locale,
                  onChanged: (value) {
                    context.read<LocalizationCubit>().changeLocal(
                        context,
                        value ??
                            context.read<LocalizationCubit>().state.locale);
                  },
                  items: const [
                    DropdownMenuItem(
                        value: AppLocale.enUS,
                        child: Text(' - EN')),
                    DropdownMenuItem(
                        value: AppLocale.ruRU,
                        child: Text(' - РУ')),
                  ]),
            ),
            SettingsItem(
              name: LocaleKeys.theme.tr(),
              widget: SwitchWidget(
                onChanged: () {
                  final theme = AdaptiveTheme.of(context);
                  if (theme.theme == theme.darkTheme) {
                    theme.setLight();
                  } else {
                    theme.setDark();
                  }
                },
                isTrue: AdaptiveTheme.of(context).theme ==
                    AdaptiveTheme.of(context).darkTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}