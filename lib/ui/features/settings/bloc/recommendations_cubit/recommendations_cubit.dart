import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'recommendations_state.dart';

class RecommendationsCubit extends HydratedCubit<RecommendationsState> {
  RecommendationsCubit() : super(const RecommendationsState());

  Future<void> addRecommendation(String text) async {
    try {
      emit(state.copyWith(asyncSnapshot: () => const AsyncSnapshot.waiting()));
      final newList = List<String>.from(state.recommendations)..add(text);

      emit(state.copyWith(
          recommendations: () => newList,
          asyncSnapshot: () => const AsyncSnapshot.withData(
            ConnectionState.done,
            "Успешно",
          )));
    } catch (error) {
      addError(error);
    }
  }

  Future<void> deleteRecommendation(int index) async {
    try {
      emit(state.copyWith(asyncSnapshot: () => const AsyncSnapshot.waiting()));
      final newList = List<String>.from(state.recommendations)..removeAt(index);

      emit(state.copyWith(
          recommendations: () => newList,
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

  @override
  RecommendationsState? fromJson(Map<String, dynamic> json) {
    return RecommendationsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RecommendationsState state) {
    return state.toJson();
  }
}
