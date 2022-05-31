import 'package:battlestats/data/local/stats_cache.dart';
import 'package:battlestats/data/remote/stats_service.dart';
import 'package:battlestats/data/repository/repository.dart';
import 'package:battlestats/models/classes/class_stats.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';

abstract class StatsRepository {
  Stream<PlayerStats?> getPlayerStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  });

  Stream<List<WeaponStats>?> getWeaponStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  });

  Stream<List<VehicleStats>?> getVehicleStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  });

  Stream<List<ClassStats>?> getClassStats(
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

  @override
  Stream<List<WeaponStats>?> getWeaponStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  }) {
    return fetchAndCache(
      accessType: accessType,
      getFromCache: () => _cache.getWeaponStats(player),
      saveToCache: (stats) => _cache.setWeaponStats(player, stats),
      getFromWeb: () => _service.getWeaponStats(player.name, player.platform),
    );
  }

  @override
  Stream<List<VehicleStats>?> getVehicleStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  }) {
    return fetchAndCache(
      accessType: accessType,
      getFromCache: () => _cache.getVehiclesStats(player),
      saveToCache: (stats) => _cache.setVehicleStats(player, stats),
      getFromWeb: () => _service.getVehicleStats(player.name, player.platform),
    );
  }

  @override
  Stream<List<ClassStats>?> getClassStats(
    Player player, {
    DataAccessType accessType = DataAccessType.localAndRemote,
  }) {
    return fetchAndCache(
      accessType: accessType,
      getFromCache: () => _cache.getClassStats(player),
      saveToCache: (stats) => _cache.setClassStats(player, stats),
      getFromWeb: () => _service.getClassStats(player.name, player.platform),
    );
  }
}
