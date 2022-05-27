import 'dart:async';

import 'package:battlestats/app/app_viewmodel.dart';
import 'package:battlestats/data/local/player_repository.dart';
import 'package:battlestats/data/remote/stats_service.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MainViewModel with ChangeNotifier {
  final Player player;
  final StatsService _service;
  final PlayerRepository _playerRepo;
  final AppViewModel _appViewModel;

  MainViewModel(this.player, this._service, this._playerRepo, this._appViewModel) {
    _init();
  }

  factory MainViewModel.of(BuildContext context, Player player) {
    return MainViewModel(
      player,
      context.read<StatsService>(),
      context.read<PlayerRepository>(),
      context.read<AppViewModel>(),
    );
  }

  var players = <Player>[];
  var isLoading = true;
  PlayerStats? stats;

  final StreamController<String> _errorController = StreamController.broadcast();

  Stream<String> get errors => _errorController.stream;

  void _init() async {
    players = await _getPlayers();
    notifyListeners();
    _loadData(player);
  }

  void _loadData(Player player) async {
    isLoading = true;
    notifyListeners();
    stats = await _service.getPlayerStats(player.name, player.platform);
    isLoading = false;
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

  Future<void> refresh() async {
    final updatedStats = await _service.getPlayerStats(player.name, player.platform);
    if (updatedStats != null) {
      stats = updatedStats;
      notifyListeners();
    } else {
      _errorController.add('Something went wrong');
    }
  }

  void retry() async {
    isLoading = true;
    notifyListeners();

    final updatedStats = await _service.getPlayerStats(player.name, player.platform);
    if (updatedStats != null) {
      stats = updatedStats;
    } else {
      _errorController.add('Something went wrong');
    }

    isLoading = false;
    notifyListeners();
  }
}
