import 'package:battlestats/common/utils/generic_utils.dart';
import 'package:battlestats/models/game_modes/game_mode_stats.dart';

class GameModeStatsResponse {
  final int? id;
  final String? username;
  final String? avatar;
  final List<GameModeStats> gameModes;

  GameModeStatsResponse({
    required this.id,
    required this.username,
    required this.avatar,
    required this.gameModes,
  });

  factory GameModeStatsResponse.fromJson(Map json) {
    return GameModeStatsResponse(
      id: castOrNull<int>(json['id']),
      username: castOrNull<String>(json['username']),
      avatar: castOrNull<String>(json['avatar']),
      gameModes: (json['gamemodes'] as List<dynamic>)
          .map((e) => GameModeStats.fromJson(e as Map))
          .toList(),
    );
  }
}
