import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/weapons/weapon_sort_mode.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';
import 'package:battlestats/models/weapons/weapon_stats_response.dart';
import 'package:battlestats/screens/weapons/weapons_viewmodel.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'common/fakes.dart';
import 'common/mocks.dart';

void main() {
  final player = Player(0, 'name', 'avatar', GamingPlatform.ps4);

  final weapon1 = _createStats(name: 'a_weapon', kills: 100, kpm: 1.0, time: 500, type: 'pistol');
  final weapon2 = _createStats(name: 'b_weapon', kills: 300, kpm: 2.0, time: 1000, type: 'lmg');
  final weapon3 = _createStats(name: 'c_weapon', kills: 200, kpm: 3.0, time: 100, type: 'rifle');

  final weaponsNotSorted = [weapon2, weapon3, weapon1];

  final sortedWeapons = {
    WeaponSortMode.name: [weapon1, weapon2, weapon3],
    WeaponSortMode.kills: [weapon2, weapon3, weapon1],
    WeaponSortMode.time: [weapon2, weapon1, weapon3],
    WeaponSortMode.kpm: [weapon2, weapon3, weapon1],
  };

  final weaponsResponse = WeaponStatsResponse(
    player.id,
    player.name,
    player.avatar,
    weaponsNotSorted.toList(),
  );

  test('Should sort correctly and save sort mode to preferences', () {
    fakeAsync((async) async {
      final preferences = FakePreferences();
      final statsService = MockStatsService();
      when(() => statsService.getWeaponStats(player.name, player.platform))
          .thenAnswer((_) => Future.value(weaponsResponse));

      final vm = WeaponsViewModel(player, statsService, preferences);
      async.elapse(const Duration(milliseconds: 1));
      expect(vm.weapons, weaponsNotSorted);

      for (var mode in WeaponSortMode.values) {
        vm.onSortModeClicked(mode);
        async.elapse(const Duration(milliseconds: 1));
        expect(vm.weapons, sortedWeapons[mode]);
        expectLater(preferences.getWeaponsSortMode(), mode);
      }
    });
  });

  test('All weapon types should be enabled by default and sorted alphabetically', () {
    fakeAsync((async) async {
      final statsService = MockStatsService();
      when(() => statsService.getWeaponStats(player.name, player.platform))
          .thenAnswer((_) => Future.value(weaponsResponse));

      final vm = WeaponsViewModel(player, statsService, FakePreferences());
      async.elapse(const Duration(milliseconds: 1));

      expect(vm.selectedWeaponTypes, [weapon2.type, weapon1.type, weapon3.type]);
    });
  });

  test('Should filter correctly and keep sort order', () {
    fakeAsync((async) async {
      final statsService = MockStatsService();
      when(() => statsService.getWeaponStats(player.name, player.platform))
          .thenAnswer((_) => Future.value(weaponsResponse));

      final vm = WeaponsViewModel(player, statsService, FakePreferences());
      async.elapse(const Duration(milliseconds: 1));

      const sortMode = WeaponSortMode.time;

      vm.onSortModeClicked(sortMode);
      async.elapse(const Duration(milliseconds: 1));

      vm.selectNoTypes();
      expect(vm.weapons, []);

      vm.onWeaponTypeClicked(weapon1.type);
      expect(vm.weapons, [weapon1]);

      vm.onWeaponTypeClicked(weapon2.type);
      expect(vm.weapons, [weapon2, weapon1]);

      vm.onWeaponTypeClicked(weapon1.type);
      expect(vm.weapons, [weapon2]);

      vm.selectAllTypes();
      expect(vm.weapons, sortedWeapons[sortMode]);
    });
  });

  test('Failed refresh should not replace already loaded data with null', () {
    fakeAsync((async) async {
      final statsService = MockStatsService();
      when(() => statsService.getWeaponStats(player.name, player.platform))
          .thenAnswer((_) => Future.value(weaponsResponse));

      final vm = WeaponsViewModel(player, statsService, FakePreferences());
      async.elapse(const Duration(milliseconds: 1));

      when(() => statsService.getWeaponStats(player.name, player.platform))
          .thenAnswer((_) => Future.value(null));

      await vm.refresh();

      expect(vm.weapons, weaponsResponse.weapons);
    });
  });
}

WeaponStats _createStats({
  String name = '',
  int kills = 0,
  double kpm = 0.0,
  int time = 0,
  String type = '',
}) {
  return WeaponStats(
    accuracy: '',
    headshotKills: 1,
    headshots: '',
    hitVKills: 0,
    image: '',
    kills: kills,
    killsPerMinute: kpm,
    shotsFired: 1,
    shotsHit: 1,
    timeEquipped: time,
    type: 'type',
    weaponName: name,
  );
}
