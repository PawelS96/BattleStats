import 'package:battlestats/models/player/player.dart';

abstract class AppState {
  AppState._();

  factory AppState.initial() = InitialLoading;

  factory AppState.noPlayerSelected() = NoPlayerSelected;

  factory AppState.playerSelected(Player player) = PlayerSelected;

  T map<T>({
    required T Function() loading,
    required T Function() noPlayerSelected,
    required T Function(Player) playerSelected,
  }) {
    if (this is PlayerSelected) {
      return playerSelected((this as PlayerSelected).player);
    }
    if (this is NoPlayerSelected) {
      return noPlayerSelected();
    }

    return loading();
  }
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
