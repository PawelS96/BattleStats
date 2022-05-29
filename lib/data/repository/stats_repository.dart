import 'package:battlestats/data/local/stats_cache.dart';
import 'package:battlestats/data/remote/stats_service.dart';
import 'package:battlestats/data/repository/repository.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/player/player_stats.dart';

abstract class StatsRepository {
  Stream<PlayerStats?> getPlayerStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  });
}

class StatsRepositoryImpl extends StatsRepository with Repository {
  final StatsCache _cache;
  final StatsService _service;

  StatsRepositoryImpl(this._cache, this._service);

  @override
  Stream<PlayerStats?> getPlayerStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  }) {
    return fetchAndCache(
      accessType: accessType,
      getFromCache: () => _cache.getPlayerStats(player),
      saveToCache: (stats) => _cache.setPlayerStats(player, stats),
      getFromWeb: () => _service.getPlayerStats(player.name, player.platform),
    );
  }
}
