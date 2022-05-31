import 'package:battlestats/data/repository/repository.dart';
import 'package:battlestats/data/repository/stats_repository.dart';
import 'package:battlestats/models/classes/class_stats.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesViewModel with ChangeNotifier {
  final Player _player;
  final StatsRepository _repository;

  ClassesViewModel(this._player, this._repository) {
    _loadData();
  }

  factory ClassesViewModel.of(BuildContext context, Player player) {
    return ClassesViewModel(player, context.read<StatsRepository>());
  }

  var classes = <ClassStats>[];
  var isLoading = false;

  void _loadData() async {
    isLoading = true;
    notifyListeners();
    _repository.getClassStats(_player).listen((data) {
      classes = data ?? [];
      _sort();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> refresh() async {
    _repository.getClassStats(_player, accessType: DataAccessType.onlyRemote).listen((data) {
      if (data != null) {
        classes = data;
        _sort();
        notifyListeners();
      }
    });
  }

  void _sort() {
    classes.sort((a, b) => b.score.compareTo(a.score));
  }
}
