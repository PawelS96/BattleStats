import 'package:battlestats/data/remote/network_client.dart';
import 'package:battlestats/models/player/get_player_response.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';

class PlayerService {
  final NetworkClient _api;

  PlayerService(this._api);

  Future<GetPlayerResponse?> getPlayer(String name, GamingPlatform platform) async {
    try {
      final response = await _api.sendRequest(
        'player',
        {
          'name': name,
          'platform': platform.name,
        },
      );

      if (response is Map && response.containsKey('errors')) {
        return PlayerNotFoundResponse();
      }

      response['platform'] = platform.name;
      final player = Player.fromJson(response);
      return PlayerFoundResponse(player);
    } catch (e) {
      return null;
    }
  }
}
