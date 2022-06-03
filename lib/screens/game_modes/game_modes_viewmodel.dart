import 'package:battlestats/data/repository/repository.dart';
import 'package:battlestats/data/repository/stats_repository.dart';
import 'package:battlestats/models/game_modes/game_mode_stats.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameModesViewModel with ChangeNotifier {
  final Player _player;
  final StatsRepository _repository;

  GameModesViewModel(this._player, this._repository) {
    _loadData();
  }

  factory GameModesViewModel.of(BuildContext context, Player player) {
    return GameModesViewModel(player, context.read<StatsRepository>());
  }

  var gameModes = <GameModeStats>[];
  var isLoading = false;

  void _loadData() async {
    isLoading = true;
    notifyListeners();
    _repository.getGameModeStats(_player).listen((data) {
      gameModes = data ?? [];
      _sortAndFilter();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> refresh() async {
    _repository.getGameModeStats(_player, accessType: DataAccessType.onlyRemote).listen((data) {
      if (data != null) {
        gameModes = data;
        _sortAndFilter();
        notifyListeners();
      }
    });
  }

  void _sortAndFilter() {
    // removing Shock Operations because API gives the same values as in Operations
    gameModes.removeWhere((e) => e.gameModeName.toLowerCase().contains('shock'));
    gameModes.sort((a, b) => (b.score ?? 0).compareTo(a.score ?? 0));
  }
}
