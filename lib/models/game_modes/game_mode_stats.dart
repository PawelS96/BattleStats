import 'package:battlestats/common/utils/generic_utils.dart';

class GameModeStats {
  String gameModeName;
  int? wins;
  int? losses;
  String? winPercent;
  int? score;

  GameModeStats({
    required this.gameModeName,
    required this.wins,
    required this.losses,
    required this.winPercent,
    required this.score,
  });

  factory GameModeStats.fromJson(Map json) {
    return GameModeStats(
      gameModeName: json['gamemodeName'],
      wins: castOrNull<int>(json['wins']),
      losses: castOrNull<int>(json['losses']),
      winPercent: castOrNull<String>(json['winPercent']),
      score: castOrNull<int>(json['score']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "gamemodeName": gameModeName,
      "wins": wins,
      "losses": losses,
      "winPercent": winPercent,
      "score": score,
    };
  }
}
