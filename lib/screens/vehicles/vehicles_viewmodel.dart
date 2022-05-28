import 'package:battlestats/data/local/preferences.dart';
import 'package:battlestats/data/remote/stats_service.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/vehicles/vehicle_sort_mode.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclesViewModel with ChangeNotifier {
  final Player _player;
  final StatsService _service;
  final Preferences _preferences;

  VehiclesViewModel(this._player, this._service, this._preferences) {
    _loadData();
  }

  factory VehiclesViewModel.of(BuildContext context, Player player) {
    return VehiclesViewModel(
      player,
      context.read<StatsService>(),
      context.read<Preferences>(),
    );
  }

  var _allVehicles = <VehicleStats>[];
  var vehicles = <VehicleStats>[];
  var isLoading = true;
  var sortMode = VehicleSortMode.kills;
  var selectedVehicleTypes = <String>[];

  void _loadData() async {
    sortMode = await _preferences.getVehiclesSortMode() ?? VehicleSortMode.kills;
    final response = await _service.getVehicleStats(_player.name, _player.platform);
    _allVehicles = response?.vehicles ?? [];
    vehicles = _allVehicles.toList();
    selectedVehicleTypes = vehicleTypes;
    _filterItems();
    _sortItems(sortMode);
    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    final response = await _service.getVehicleStats(_player.name, _player.platform);
    if (response != null) {
      _allVehicles = response.vehicles ?? [];
      vehicles = _allVehicles.toList();
      _filterItems();
      _sortItems(sortMode);
      notifyListeners();
    }
  }

  void onSortModeClicked(VehicleSortMode mode) {
    sortMode = mode;
    _sortItems(mode);
    notifyListeners();
    _preferences.setVehiclesSortMode(mode);
  }

  List<String> get vehicleTypes {
    return _allVehicles.map((e) => _getVehicleType(e)).toSet().toList()..sort();
  }

  void onVehicleTypeClicked(String type) {
    if (selectedVehicleTypes.contains(type)) {
      selectedVehicleTypes.remove(type);
    } else {
      selectedVehicleTypes.add(type);
    }
    _filterItems();
    _sortItems(sortMode);
    notifyListeners();
  }

  void selectAllTypes() {
    selectedVehicleTypes = vehicleTypes.toList();
    _filterItems();
    _sortItems(sortMode);
    notifyListeners();
  }

  void selectNoTypes() {
    selectedVehicleTypes = [];
    _filterItems();
    _sortItems(sortMode);
    notifyListeners();
  }

  void _filterItems() {
    vehicles =
        _allVehicles.where((e) => selectedVehicleTypes.contains(_getVehicleType(e))).toList();
  }

  String _getVehicleType(VehicleStats vehicle) {
    switch (vehicle.type.toLowerCase()) {
      case 'artillery truck':
      case 'assault tank':
      case 'assault truck':
      case 'heavy tank':
      case 'landship':
      case 'light tank':
        return 'Armored land vehicle';
      case 'boat':
      case 'destroyer':
        return 'Water vehicle';
      default:
        return vehicle.type;
    }
  }

  void _sortItems(VehicleSortMode mode) {
    switch (mode) {
      case VehicleSortMode.name:
        vehicles = vehicles.sortedBy((v) => v.formattedName.toLowerCase());
        break;
      case VehicleSortMode.kills:
        vehicles.sort((a, b) => b.kills.compareTo(a.kills));
        break;
      case VehicleSortMode.kpm:
        vehicles.sort((a, b) => b.killsPerMinute.compareTo(a.killsPerMinute));
        break;
      case VehicleSortMode.time:
        vehicles.sort((a, b) => b.timeIn.compareTo(a.timeIn));
        break;
    }
  }
}
