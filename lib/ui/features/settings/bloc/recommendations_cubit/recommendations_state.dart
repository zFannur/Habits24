part of 'recommendations_cubit.dart';

const listRecommendations = [
  'Главное фокусировка на одной цели',
  'Упорство и труд всех перетрут',
  'Дисциплина это не ограничение, а отсечение всего лишнего'
];

final class RecommendationsState extends Equatable {
  const RecommendationsState({
    this.asyncSnapshot,
    this.recommendations = listRecommendations,
  });

  final AsyncSnapshot? asyncSnapshot;
  final List<String> recommendations;

  RecommendationsState copyWith({
    AsyncSnapshot Function()? asyncSnapshot,
    List<String> Function()? recommendations,
  }) {
    return RecommendationsState(
      asyncSnapshot:
          asyncSnapshot != null ? asyncSnapshot() : this.asyncSnapshot,
      recommendations:
          recommendations != null ? recommendations() : this.recommendations,
    );
  }

  factory RecommendationsState.fromJson(Map<String, dynamic> json) {
    return RecommendationsState(
      recommendations:
          (json['recommendations'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendations': recommendations,
    };
  }

  @override
  List<Object?> get props => [
        asyncSnapshot,
        recommendations,
      ];
}
