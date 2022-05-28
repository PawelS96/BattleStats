import 'package:battlestats/data/remote/network_client.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:battlestats/models/weapons/weapon_stats_response.dart';

class StatsService {
  final NetworkClient _api;

  StatsService(this._api);

  Future<PlayerStats?> getPlayerStats(String playerName, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'stats',
      {
        'name': playerName,
        'platform': platform.name,
      },
    );

    if (response is Map && response.containsKey('errors')) {
      return null;
    }

    try {
      return PlayerStats.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<WeaponStatsResponse?> getWeaponStats(String playerName, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'weapons',
      {
        'name': playerName,
        'platform': platform.name,
      },
    );

    if (response is Map && response.containsKey('errors')) {
      return null;
    }

    try {
      return WeaponStatsResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}

