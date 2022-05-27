import 'package:battlestats/app/app_viewmodel.dart';
import 'package:battlestats/data/local/player_repository.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MainViewModel with ChangeNotifier {
  final Player player;
  final PlayerRepository _playerRepo;
  final AppViewModel _appViewModel;

  MainViewModel(this.player, this._playerRepo, this._appViewModel) {
    _init();
  }

  factory MainViewModel.of(BuildContext context, Player player) {
    return MainViewModel(
      player,
      context.read<PlayerRepository>(),
      context.read<AppViewModel>(),
    );
  }

  var players = <Player>[];

  void _init() async {
    players = await _getPlayers();
    notifyListeners();
  }

  void deletePlayer(Player player) async {
    final selectedPlayer = await _playerRepo.getSelectedPlayer();
    await _playerRepo.deletePlayer(player);
    players = await _getPlayers();

    if (players.isEmpty) {
      _appViewModel.changePlayer(null);
    } else if (player == selectedPlayer) {
      _appViewModel.changePlayer(players.first);
    } else {
      notifyListeners();
    }
  }

  void selectPlayer(Player player) {
    _appViewModel.changePlayer(player);
  }

  void onPlayerAdded(Player player) async {
    selectPlayer(player);
  }

  Future<List<Player>> _getPlayers() async {
    final players = await _playerRepo.getPlayers();
    return players.sortedBy((element) => element.name);
  }
}
