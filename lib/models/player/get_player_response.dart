import 'package:battlestats/models/player/player.dart';

sealed class GetPlayerResponse {}

class PlayerFoundResponse extends GetPlayerResponse {
  final Player player;

  PlayerFoundResponse(this.player);
}

class PlayerNotFoundResponse extends GetPlayerResponse {}