part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.asyncSnapshot,
    this.error,
    this.files = const [],
    this.isRegisterSaveDataTask,
    this.isEnabledSaveDataTask = false,
  });

  final AsyncSnapshot? asyncSnapshot;
  final String? error;
  final List<File> files;
  final bool? isRegisterSaveDataTask;
  final bool isEnabledSaveDataTask;

  SettingsState copyWith({
    AsyncSnapshot Function()? asyncSnapshot,
    String Function()? error,
    List<File> Function()? files,
    bool Function()? isRegisterSaveDataTask,
    bool Function()? isEnabledSaveDataTask,
  }) {
    return SettingsState(
      asyncSnapshot:
          asyncSnapshot != null ? asyncSnapshot() : this.asyncSnapshot,
      error: error != null ? error() : this.error,
      files: files != null ? files() : this.files,
      isRegisterSaveDataTask: isRegisterSaveDataTask != null
          ? isRegisterSaveDataTask()
          : this.isRegisterSaveDataTask,
      isEnabledSaveDataTask: isEnabledSaveDataTask != null
          ? isEnabledSaveDataTask()
          : this.isEnabledSaveDataTask,
    );
  }

  @override
  List<Object?> get props => [
        asyncSnapshot,
        error,
        files,
        isEnabledSaveDataTask,
        isRegisterSaveDataTask,
      ];
}
