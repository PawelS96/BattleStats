import 'package:battlestats/models/player/player.dart';

abstract class AddPlayerEvent {}

class PlayerAdded extends AddPlayerEvent {
  final Player player;

  PlayerAdded(this.player);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdded && runtimeType == other.runtimeType && player == other.player;

  @override
  int get hashCode => player.hashCode;
}

class PlayerAddError extends AddPlayerEvent {
  final String message;

  PlayerAddError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAddError && runtimeType == other.runtimeType && message == other.message;

  @override
  int get hashCode => message.hashCode;
}
