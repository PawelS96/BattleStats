import 'dart:convert';

import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsCache {
  Future<PlayerStats?> getPlayerStats(Player player) async {
    final sp = await SharedPreferences.getInstance();
    final savedValue = sp.getString(_getKey(player));
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
    sp.setString(_getKey(player), json);
  }

  String _getKey(Player player) {
    return '${player.name}_${player.platform.name}';
  }
}
