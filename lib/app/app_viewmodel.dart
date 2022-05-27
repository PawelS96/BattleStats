import 'package:battlestats/app/app_state.dart';
import 'package:battlestats/data/local/player_repository.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppViewModel with ChangeNotifier {
  final PlayerRepository _playerRepo;

  AppViewModel(this._playerRepo) {
    _setState();
  }

  factory AppViewModel.of(BuildContext context) {
    return AppViewModel(context.read<PlayerRepository>());
  }

  AppState state = AppState.initial();

  Player? get currentPlayer {
    final currentState = state;
    return currentState is PlayerSelected ? currentState.player : null;
  }

  void _setState() {
    _playerRepo.getSelectedPlayer().then((player) {
      state = player == null ? AppState.noPlayerSelected() : AppState.playerSelected(player);
      notifyListeners();
    });
  }

  void changePlayer(Player? player) async {
    await _playerRepo.setSelectedPlayer(player);
    _setState();
  }
}
