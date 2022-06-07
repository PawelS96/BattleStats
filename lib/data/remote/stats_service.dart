import 'package:battlestats/data/remote/network_client.dart';
import 'package:battlestats/models/classes/class_stats.dart';
import 'package:battlestats/models/classes/class_stats_response.dart';
import 'package:battlestats/models/game_modes/game_mode_stats.dart';
import 'package:battlestats/models/game_modes/game_mode_stats_response.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:battlestats/models/progress/progress_stats.dart';
import 'package:battlestats/models/progress/progress_stats_response.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:battlestats/models/vehicles/vehicle_stats_response.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';
import 'package:battlestats/models/weapons/weapon_stats_response.dart';

class StatsService {
  final NetworkClient _api;

  StatsService(this._api);

  Future<PlayerStats?> getPlayerStats(int playerId, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'stats',
      {
        'playerid': playerId,
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

  Future<List<WeaponStats>?> getWeaponStats(int playerId, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'weapons',
      {
        'playerid': playerId,
        'platform': platform.name,
      },
    );

    if (response is Map && response.containsKey('errors')) {
      return null;
    }

    try {
      return WeaponStatsResponse.fromJson(response).weapons;
    } catch (e) {
      return null;
    }
  }

  Future<List<VehicleStats>?> getVehicleStats(int playerId, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'vehicles',
      {
        'playerid': playerId,
        'platform': platform.name,
      },
    );

    if (response is Map && response.containsKey('errors')) {
      return null;
    }

    try {
      return VehicleStatsResponse.fromJson(response).vehicles;
    } catch (e) {
      return null;
    }
  }

  Future<List<ClassStats>?> getClassStats(int playerId, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'classes',
      {
        'playerid': playerId,
        'platform': platform.name,
      },
    );

    if (response is Map && response.containsKey('errors')) {
      return null;
    }

    try {
      return ClassStatsResponse.fromJson(response).classes;
    } catch (e) {
      return null;
    }
  }

  Future<List<GameModeStats>?> getGameModeStats(int playerId, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'gamemode',
      {
        'playerid': playerId,
        'platform': platform.name,
      },
    );

    if (response is Map && response.containsKey('errors')) {
      return null;
    }

    try {
      return GameModeStatsResponse.fromJson(response).gameModes;
    } catch (e) {
      return null;
    }
  }

  Future<List<ProgressStats>?> getProgressStats(int playerId, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'progress',
      {
        'playerid': playerId,
        'platform': platform.name,
      },
    );

    if (response is Map && response.containsKey('errors')) {
      return null;
    }

    try {
      return ProgressStatsResponse.fromJson(response).progress;
    } catch (e) {
      return null;
    }
  }
}

