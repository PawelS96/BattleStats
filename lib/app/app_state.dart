import 'package:battlestats/models/player/player.dart';

sealed class AppState {
  AppState._();

  factory AppState.initial() = InitialLoading;

  factory AppState.noPlayerSelected() = NoPlayerSelected;

  factory AppState.playerSelected(Player player) = PlayerSelected;
}

class InitialLoading extends AppState {
  InitialLoading() : super._();
}

class NoPlayerSelected extends AppState {
  NoPlayerSelected() : super._();
}

class PlayerSelected extends AppState {
  final Player player;

  PlayerSelected(this.player) : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerSelected && runtimeType == other.runtimeType && player == other.player;

  @override
  int get hashCode => player.hashCode;
}
