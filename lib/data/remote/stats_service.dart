import 'package:battlestats/data/remote/network_client.dart';
import 'package:battlestats/models/classes/class_stats.dart';
import 'package:battlestats/models/classes/class_stats_response.dart';
import 'package:battlestats/models/game_modes/game_mode_stats.dart';
import 'package:battlestats/models/game_modes/game_mode_stats_response.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:battlestats/models/vehicles/vehicle_stats_response.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';
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

  Future<List<WeaponStats>?> getWeaponStats(String playerName, GamingPlatform platform) async {
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
      return WeaponStatsResponse.fromJson(response).weapons;
    } catch (e) {
      return null;
    }
  }

  Future<List<VehicleStats>?> getVehicleStats(String playerName, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'vehicles',
      {
        'name': playerName,
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

  Future<List<ClassStats>?> getClassStats(String playerName, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'classes',
      {
        'name': playerName,
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

  Future<List<GameModeStats>?> getGameModeStats(String playerName, GamingPlatform platform) async {
    final response = await _api.sendRequest(
      'gamemode',
      {
        'name': playerName,
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
}

