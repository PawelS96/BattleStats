import 'package:battlestats/data/repository/repository.dart';
import 'package:battlestats/data/repository/stats_repository.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/progress/progress_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressViewModel with ChangeNotifier {
  final Player _player;
  final StatsRepository _repository;

  ProgressViewModel(this._player, this._repository) {
    _loadData();
  }

  factory ProgressViewModel.of(BuildContext context, Player player) {
    return ProgressViewModel(player, context.read<StatsRepository>());
  }

  var progress = <ProgressStats>[];
  var isLoading = false;

  void _loadData() async {
    isLoading = true;
    notifyListeners();
    _repository.getProgressStats(_player).listen((data) {
      progress = data ?? [];
      _sort();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> refresh() async {
    _repository.getProgressStats(_player, accessType: DataAccessType.onlyRemote).listen((data) {
      if (data != null) {
        progress = data;
        _sort();
        notifyListeners();
      }
    });
  }

  Future<void> retry() async {
    isLoading = true;
    notifyListeners();
    _repository.getProgressStats(_player).listen((data) {
      if (data != null) {
        progress = data;
        _sort();
      }
      isLoading = false;
      notifyListeners();
    });
  }

  void _sort() {
    progress.sort((a, b) => a.name.compareTo(b.name));
  }
}
