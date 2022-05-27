import 'package:battlestats/data/local/player_repository.dart';
import 'package:battlestats/models/player/player.dart';

class FakePlayerRepository implements PlayerRepository {
  Player? _selectedPlayer;
  final _players = <Player>[];

  FakePlayerRepository({Player? selectedPlayer}) {
    _selectedPlayer = selectedPlayer;
  }

  @override
  Future<void> addPlayer(Player player) async {
    _players.add(player);
  }

  @override
  Future<void> deletePlayer(Player player) async {
    _players.remove(player);
  }

  @override
  Future<List<Player>> getPlayers() async {
    return _players;
  }

  @override
  Future<Player?> getSelectedPlayer() async {
    return _selectedPlayer;
  }

  @override
  Future<void> setSelectedPlayer(Player? player) async {
    _selectedPlayer = player;
  }
}
