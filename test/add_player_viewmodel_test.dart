import 'package:battlestats/models/player/get_player_response.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/screens/add_player/add_player_event.dart';
import 'package:battlestats/screens/add_player/add_player_viewmodel.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'common/mocks.dart';

void main() {
  test('Test name validation', () {
    final invalidNames = [null, '', '  '];
    final validName = ['Player', 'other player', 'player1'];

    final vm = AddPlayerViewModel(MockPlayerRepo(), MockPlayerService());

    for (var name in invalidNames) {
      expect(vm.validatePlayerName(name) != null, true);
    }

    for (var name in validName) {
      expect(vm.validatePlayerName(name) == null, true);
    }
  });

  test('Adding an already added player should show an error and not try to add the player again',
      () {
    fakeAsync((async) {
      final player = Player(0, 'name', 'avatar', GamingPlatform.pc);

      final playerRepo = MockPlayerRepo();
      when(() => playerRepo.getPlayers()).thenAnswer((invocation) => Future.value([player]));

      final vm = AddPlayerViewModel(playerRepo, MockPlayerService());

      final events = <AddPlayerEvent>[];

      vm.events.listen((event) {
        events.add(event);
      });

      vm.addPlayer(player.name, player.platform);
      async.elapse(const Duration(milliseconds: 1));

      expect(events.length, 1);
      expect(events.first is PlayerAddError, true);
      verifyNever(() => playerRepo.addPlayer(player));
    });
  });

  test('When player was not found it should show an error and stop loading', () {
    fakeAsync((async) {
      const name = 'name';
      const platform = GamingPlatform.pc;

      final playerRepo = MockPlayerRepo();
      when(() => playerRepo.getPlayers()).thenAnswer((_) => Future.value([]));

      final playerService = MockPlayerService();
      when(() => playerService.getPlayer(name, platform))
          .thenAnswer((_) => Future.value(PlayerNotFoundResponse()));

      final vm = AddPlayerViewModel(playerRepo, playerService);

      final events = <AddPlayerEvent>[];

      vm.events.listen((event) {
        events.add(event);
      });

      vm.addPlayer(name, platform);
      expect(vm.isLoading, true);

      async.elapse(const Duration(milliseconds: 1));

      expect(events.length, 1);
      expect(events.first is PlayerAddError, true);
      expect(vm.isLoading, false);
    });
  });

  test('When fetching the player failed it should show an error and stop loading', () {
    fakeAsync((async) {
      const name = 'name';
      const platform = GamingPlatform.pc;

      final playerRepo = MockPlayerRepo();
      when(() => playerRepo.getPlayers()).thenAnswer((_) => Future.value([]));

      final playerService = MockPlayerService();
      when(() => playerService.getPlayer(name, platform)).thenAnswer((_) => Future.value(null));

      final vm = AddPlayerViewModel(playerRepo, playerService);

      final events = <AddPlayerEvent>[];

      vm.events.listen((event) {
        events.add(event);
      });

      vm.addPlayer(name, platform);
      expect(vm.isLoading, true);

      async.elapse(const Duration(milliseconds: 1));

      expect(events.length, 1);
      expect(events.first is PlayerAddError, true);
      expect(vm.isLoading, false);
    });
  });

  test('When fetching the player is successful it should save the player and emit an event', () {
    fakeAsync((async) {
      final player = Player(0, 'name', 'avatar', GamingPlatform.pc);

      final playerRepo = MockPlayerRepo();
      when(() => playerRepo.getPlayers()).thenAnswer((_) => Future.value([]));
      when(() => playerRepo.addPlayer(player)).thenAnswer((_) => Future.value());

      final playerService = MockPlayerService();
      when(() => playerService.getPlayer(player.name, player.platform))
          .thenAnswer((_) => Future.value(PlayerFoundResponse(player)));

      final vm = AddPlayerViewModel(playerRepo, playerService);

      final events = <AddPlayerEvent>[];

      vm.events.listen((event) {
        events.add(event);
      });

      vm.addPlayer(player.name, player.platform);
      expect(vm.isLoading, true);

      async.elapse(const Duration(seconds: 1));

      expect(events.length, 1);
      expect(events.first, PlayerAdded(player));

      verify(() => playerRepo.addPlayer(player)).called(1);
    });
  });
}
