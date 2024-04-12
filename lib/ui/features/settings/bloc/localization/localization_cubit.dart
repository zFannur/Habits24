import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState());

  Future<void> changeLocal(BuildContext context, Locale locale) async {
    try {
      emit(state.copyWith(asyncSnapshot: () => const AsyncSnapshot.waiting()));

      await context.setLocale(locale);

      emit(state.copyWith(
        locale: () => locale,
          asyncSnapshot: () => const AsyncSnapshot.withData(
            ConnectionState.done,
            "Успешно",
          )));
    } catch (error) {
      addError(error);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(
        asyncSnapshot: () => AsyncSnapshot.withError(
          ConnectionState.done,
          error,
        )));
    super.addError(error, stackTrace);
  }
}
