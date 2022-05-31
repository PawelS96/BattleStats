import 'dart:convert';

import 'package:battlestats/common/utils/generic_utils.dart';
import 'package:battlestats/models/classes/class_stats.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsCache {
  Future<PlayerStats?> getPlayerStats(Player player) async {
    final sp = await SharedPreferences.getInstance();
    final savedValue = tryOrNull(() => sp.getString(_getPlayerStatsKey(player)));
    if (savedValue == null) {
      return null;
    }

    try {
      final json = jsonDecode(savedValue);
      return PlayerStats.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<void> setPlayerStats(Player player, PlayerStats stats) async {
    final sp = await SharedPreferences.getInstance();
    final json = jsonEncode(stats.toJson());
    sp.setString(_getPlayerStatsKey(player), json);
  }

  Future<List<WeaponStats>?> getWeaponStats(Player player) async {
    return _getList(_getClassStatsKey(player), WeaponStats.fromJson);
  }

  Future<void> setWeaponStats(Player player, List<WeaponStats> stats) async {
    _setList<WeaponStats>(stats, _getWeaponStatsKey(player), (stats) => stats.toJson());
  }

  Future<void> setVehicleStats(Player player, List<VehicleStats> stats) async {
    _setList<VehicleStats>(stats, _getVehiclesStatsKey(player), (stats) => stats.toJson());
  }

  Future<List<VehicleStats>?> getVehiclesStats(Player player) async {
    return _getList(_getVehiclesStatsKey(player), VehicleStats.fromJson);
  }

  Future<void> setClassStats(Player player, List<ClassStats> stats) async {
    _setList<ClassStats>(stats, _getClassStatsKey(player), (stats) => stats.toJson());
  }

  Future<List<ClassStats>?> getClassStats(Player player) async {
    return _getList(_getClassStatsKey(player), ClassStats.fromJson);
  }

  Future<void> clearCache(Player player) async {
    final sp = await SharedPreferences.getInstance();
    final keys = [
      _getPlayerStatsKey(player),
      _getVehiclesStatsKey(player),
      _getWeaponStatsKey(player),
      _getClassStatsKey(player),
    ];

    for (var key in keys) {
      await sp.remove(key);
    }
  }

  Future<void> _setList<T>(
    List<T> items,
    String key,
    Map<String, dynamic> Function(T) jsonMapper,
  ) async {
    final sp = await SharedPreferences.getInstance();
    final json = items.map((e) => jsonEncode(jsonMapper(e))).toList();
    sp.setStringList(key, json);
  }

  Future<List<T>?> _getList<T>(
    String key,
    T Function(Map<String, dynamic>) jsonConstructor,
  ) async {
    final sp = await SharedPreferences.getInstance();
    final savedValue = tryOrNull(() => sp.getStringList(key));
    if (savedValue == null) {
      return null;
    }

    final allStats = <T>[];
    for (var json in savedValue) {
      try {
        final stats = jsonConstructor(jsonDecode(json));
        allStats.add(stats);
      } catch (e) {
        // ignore
      }
    }

    return allStats;
  }

  String _getPlayerStatsKey(Player player) => _getKey(player, 'playerStats');

  String _getVehiclesStatsKey(Player player) => _getKey(player, 'vehicleStats');

  String _getWeaponStatsKey(Player player) => _getKey(player, 'weaponStats');

  String _getClassStatsKey(Player player) => _getKey(player, 'classStats');

  String _getKey(Player player, String suffix) {
    return '${player.name}_${player.platform.name}_$suffix';
  }
}
