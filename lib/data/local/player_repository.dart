import 'dart:convert';

import 'package:battlestats/models/player/player.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerRepository {
  static const _keySelectedPlayerId = 'selected_player_id';
  static const _keyPlayers = 'players';

  Future<List<Player>> getPlayers() async {
    final sp = await SharedPreferences.getInstance();
    final list = sp.getStringList(_keyPlayers) ?? [];
    final players = <Player>[];

    for (var string in list) {
      try {
        final player = Player.fromJson(jsonDecode(string));
        players.add(player);
      } catch (e) {
        // ignore
      }
    }

    return players;
  }

  Future<void> addPlayer(Player player) async {
    final sp = await SharedPreferences.getInstance();
    final players = await getPlayers();
    players.add(player);

    final jsonList = players.map((e) => jsonEncode(e.toJson())).toList();
    sp.setStringList(_keyPlayers, jsonList);
  }

  Future<void> deletePlayer(Player player) async {
    final sp = await SharedPreferences.getInstance();
    final players = await getPlayers();
    players.remove(player);

    final jsonList = players.map((e) => jsonEncode(e.toJson())).toList();
    sp.setStringList(_keyPlayers, jsonList);
  }

  Future<void> setSelectedPlayer(Player? player) async {
    final sp = await SharedPreferences.getInstance();
    if (player == null) {
      sp.remove(_keySelectedPlayerId);
    } else {
      sp.setInt(_keySelectedPlayerId, player.id);
    }
  }

  Future<Player?> getSelectedPlayer() async {
    final players = await getPlayers();
    final sp = await SharedPreferences.getInstance();
    final id = sp.getInt(_keySelectedPlayerId);

    return players.firstWhereOrNull((e) => e.id == id);
  }
}
