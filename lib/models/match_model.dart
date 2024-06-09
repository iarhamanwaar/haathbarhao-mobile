import 'package:haathbarhao_mobile/models/user_model.dart';

class MatchModel {
  final User doer;
  final int score;
  final int level;
  final int distance;

  MatchModel({
    required this.doer,
    required this.score,
    required this.level,
    required this.distance,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      doer: User.fromJson(json['doer']),
      score: json['score'],
      level: json['level'],
      distance: json['distance'],
    );
  }
}
