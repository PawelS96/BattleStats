import 'package:battlestats/data/local/player_repository.dart';
import 'package:battlestats/data/local/preferences.dart';
import 'package:battlestats/data/remote/stats_service.dart';
import 'package:battlestats/models/classes/class_stats_response.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:battlestats/models/vehicles/vehicle_sort_mode.dart';
import 'package:battlestats/models/vehicles/vehicle_stats_response.dart';
import 'package:battlestats/models/weapons/weapon_sort_mode.dart';
import 'package:battlestats/models/weapons/weapon_stats_response.dart';

class FakePlayerRepository implements PlayerRepository {
  Player? _selectedPlayer;
  final _players = <Player>[];

  FakePlayerRepository({Player? selectedPlayer}) {
    _selectedPlayer = selectedPlayer;
  }

  @override
  Future<void> addPlayer(Player player) async {
    _players.add(player);
  }

  @override
  Future<void> deletePlayer(Player player) async {
    _players.remove(player);
  }

  @override
  Future<List<Player>> getPlayers() async {
    return _players;
  }

  @override
  Future<Player?> getSelectedPlayer() async {
    return _selectedPlayer;
  }

  @override
  Future<void> setSelectedPlayer(Player? player) async {
    _selectedPlayer = player;
  }
}

class FakeStatsService implements StatsService {
  static final defaultStats = PlayerStats.fromJson({});

  final PlayerStats? stats;
  final WeaponStatsResponse? weaponStats;
  final VehicleStatsResponse? vehicleStats;
  final ClassStatsResponse? classStats;

  FakeStatsService({this.stats, this.weaponStats, this.vehicleStats, this.classStats});

  @override
  Future<PlayerStats?> getPlayerStats(String playerName, GamingPlatform platform) async {
    return stats;
  }

  @override
  Future<WeaponStatsResponse?> getWeaponStats(String playerName, GamingPlatform platform) async {
    return weaponStats;
  }

  @override
  Future<VehicleStatsResponse?> getVehicleStats(String playerName, GamingPlatform platform) async {
    return vehicleStats;
  }

  @override
  Future<ClassStatsResponse?> getClassStats(String playerName, GamingPlatform platform) async {
    return classStats;
  }
}

class FakePreferences implements Preferences {
  WeaponSortMode? _weaponSortMode;
  VehicleSortMode? _vehicleSortMode;

  @override
  Future<WeaponSortMode?> getWeaponsSortMode() {
    return Future.value(_weaponSortMode);
  }

  @override
  Future<void> setWeaponsSortMode(WeaponSortMode mode) async {
    _weaponSortMode = mode;
  }

  @override
  Future<VehicleSortMode?> getVehiclesSortMode() {
    return Future.value(_vehicleSortMode);
  }

  @override
  Future<void> setVehiclesSortMode(VehicleSortMode mode) async {
    _vehicleSortMode = mode;
  }
}
