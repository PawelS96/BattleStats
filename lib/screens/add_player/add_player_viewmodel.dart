import 'dart:async';

import 'package:battlestats/data/local/player_repository.dart';
import 'package:battlestats/data/remote/player_service.dart';
import 'package:battlestats/models/player/get_player_response.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/screens/add_player/add_player_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddPlayerViewModel with ChangeNotifier {
  final PlayerRepository _playerRepo;
  final PlayerService _playerService;

  AddPlayerViewModel(this._playerRepo, this._playerService);

  factory AddPlayerViewModel.of(BuildContext context) {
    return AddPlayerViewModel(
      context.read<PlayerRepository>(),
      context.read<PlayerService>(),
    );
  }

  var isLoading = false;

  final StreamController<AddPlayerEvent> _eventsController = StreamController();

  Stream<AddPlayerEvent> get events => _eventsController.stream;

  void addPlayer(String name, GamingPlatform platform) async {
    isLoading = true;
    notifyListeners();

    final players = await _playerRepo.getPlayers();
    if (players.any((e) => e.platform == platform && e.name.toLowerCase() == name.toLowerCase())) {
      _eventsController.add(PlayerAddError('This player is already added'));
      isLoading = false;
      notifyListeners();
      return;
    }

    final response = await _playerService.getPlayer(name, platform);
    switch (response) {
      case PlayerFoundResponse():
        final player = response.player;
        _playerRepo.addPlayer(player);
        _eventsController.add(PlayerAdded(player));
        break;
      case PlayerNotFoundResponse():
        _eventsController.add(PlayerAddError('Player not found'));
        isLoading = false;
        notifyListeners();
        break;
      case null:
        _eventsController.add(PlayerAddError('Something went wrong'));
        isLoading = false;
        notifyListeners();
        break;
    }
  }

  String? validatePlayerName(String? name) {
    return name?.trim().isNotEmpty != true ? 'Name cannot be empty' : null;
  }
}
