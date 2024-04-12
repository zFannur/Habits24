import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits24/app/app.dart';
import 'package:habits24/domain/domain.dart';
import 'package:habits24/generated/locale_keys.g.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required this.habitsRepository,
  }) : super(const SettingsState(asyncSnapshot: AsyncSnapshot.nothing()));

  final HabitsRepositoryInterface habitsRepository;
  //final ExcelUseCase excelUseCase = ExcelUseCase();
  final AppShare appShare = AppShare();
  final AppFilesManager appFilesManager = AppFilesManager();
  final AppSavedVariables appSavedVariables = AppSavedVariables();

  Future<void> sendMessageWithFile(String filePath) async {
    try {
      await appShare.sendMessageWithFile(filePath);
    } catch (error) {
      addError(error);
    }
  }

  Future<void> deleteFile(String filePath) async {
    try {
      emit(state.copyWith(asyncSnapshot: () => const AsyncSnapshot.waiting()));
      await appFilesManager.deleteFile(filePath);
      getSavedExcelFiles();
    } catch (error) {
      addError(error);
    }
  }

  Future<void> saveDataFromExcel({
    required List<Habit> habits,
    bool delete = true,
  }) async {
    habitsRepository.addFromFile(habits, delete: delete);
  }

  Future<void> getSavedVariables() async {
    final lastExportDate = await appSavedVariables.getLastExportDate();
    final isSaveDataEnable = lastExportDate != null ? true : false;

    emit(state.copyWith(
        isEnabledSaveDataTask: () => isSaveDataEnable,
        isRegisterSaveDataTask: () => isSaveDataEnable,
        asyncSnapshot: () => AsyncSnapshot.nothing()));
  }

  Future<List<File>?> getSavedExcelFiles() async {
    try {
      emit(state.copyWith(asyncSnapshot: () => const AsyncSnapshot.waiting()));

      final result = await appFilesManager.getSavedExcelFiles();



      emit(state.copyWith(
          files: () => result,
          asyncSnapshot: () => AsyncSnapshot.withData(
                ConnectionState.done,
                LocaleKeys.successfully.tr(),
              )));
      return result;
    } catch (error) {
      addError(error);
      return null;
    }
  }

  // Future<void> exportToExcel(
  //     List<Operation> operations, List<Plan> plans) async {
  //   try {
  //     //emit(state.copyWith(asyncSnapshot: () => const AsyncSnapshot.waiting()));
  //
  //     await excelUseCase.exportToExcel(operations, plans);
  //
  //     getSavedExcelFiles();
  //   } catch (error) {
  //     addError(error);
  //   }
  // }
  //
  // Future<ExcelSheet> importFromExcel({String? filePath}) async {
  //   try {
  //     emit(state.copyWith(asyncSnapshot: () => const AsyncSnapshot.waiting()));
  //
  //     final result =
  //         await excelUseCase.importOperationsFromExcel(filePath: filePath);
  //
  //     emit(state.copyWith(
  //         asyncSnapshot: () => AsyncSnapshot.withData(
  //               ConnectionState.done,
  //               LocaleKeys.successfully.tr(),
  //             )));
  //     return result;
  //   } catch (error) {
  //     addError(error);
  //     return ExcelSheet(operations: [], plans: []);
  //   }
  // }

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
