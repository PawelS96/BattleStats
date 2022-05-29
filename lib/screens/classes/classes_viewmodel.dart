import 'package:battlestats/data/remote/stats_service.dart';
import 'package:battlestats/models/classes/class_stats.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesViewModel with ChangeNotifier {
  final Player _player;
  final StatsService _statsService;

  ClassesViewModel(this._player, this._statsService) {
    _loadData();
  }

  factory ClassesViewModel.of(BuildContext context, Player player) {
    return ClassesViewModel(player, context.read<StatsService>());
  }

  var classes = <ClassStats>[];
  var isLoading = false;

  void _loadData() async {
    isLoading = true;
    notifyListeners();
    final response = await _statsService.getClassStats(_player.name, _player.platform);
    classes = response?.classes ?? [];
    _sort();
    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    final response = await _statsService.getClassStats(_player.name, _player.platform);
    if (response != null) {
      classes = response.classes;
      _sort();
      notifyListeners();
    }
  }

  void _sort() {
    classes.sort((a, b) => b.score.compareTo(a.score));
  }
}
