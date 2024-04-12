part of 'localization_cubit.dart';

final class LocalizationState extends Equatable {
  const LocalizationState({
    this.asyncSnapshot,
    this.locale = AppLocale.ruRU,
  });

  final AsyncSnapshot? asyncSnapshot;
  final Locale locale;

  LocalizationState copyWith({
    AsyncSnapshot Function()? asyncSnapshot,
    Locale Function()? locale,
  }) {
    return LocalizationState(
      asyncSnapshot: asyncSnapshot != null ? asyncSnapshot() : this.asyncSnapshot,
      locale: locale != null ? locale() : this.locale,
    );
  }

  @override
  List<Object?> get props => [
    asyncSnapshot,
    locale,
  ];
}
