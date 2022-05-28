import 'package:battlestats/models/weapons/weapon_sort_mode.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const _keyWeaponSort = 'weapon_sort';

  Future<void> setWeaponsSortMode(WeaponSortMode mode) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(_keyWeaponSort, mode.name);
  }

  Future<WeaponSortMode?> getWeaponsSortMode() async {
    final sp = await SharedPreferences.getInstance();
    final savedValue = sp.getString(_keyWeaponSort);
    return WeaponSortMode.values.firstWhereOrNull((element) => element.name == savedValue);
  }
}
