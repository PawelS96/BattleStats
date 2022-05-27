import 'package:battlestats/app/app_state.dart';
import 'package:battlestats/app/app_viewmodel.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/screens/main/main_viewmodel.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'common/fakes.dart';
import 'common/mocks.dart';

void main() {
  test('Players should be sorted by name ascending', () {
    fakeAsync((async) {
      final player1 = Player(0, 'z_player', 'avatar', GamingPlatform.xboxone);
      final player2 = Player(1, 'a_player', 'avatar', GamingPlatform.pc);
      final player3 = Player(2, 'k_player', 'avatar', GamingPlatform.ps4);
      final player4 = Player(3, 'g_player', 'avatar', GamingPlatform.ps4);

      final savedPlayers = [player1, player2, player3, player4];

      final playerRepo = MockPlayerRepo();
      when(() => playerRepo.getPlayers()).thenAnswer((_) => Future.value(savedPlayers));

      final vm = MainViewModel(player3, playerRepo, MockAppViewModel());
      async.elapse(const Duration(milliseconds: 1));

      expect(vm.players, [player2, player4, player3, player1]);
    });
  });

  test('Player should be selected after being added', () {
    fakeAsync((async) async {
      final player = Player(0, 'player', 'avatar', GamingPlatform.xboxone);
      final playerRepo = FakePlayerRepository(selectedPlayer: player);
      final appVM = AppViewModel(playerRepo);
      final vm = MainViewModel(player, playerRepo, appVM);
      async.elapse(const Duration(milliseconds: 1));

      final addedPlayer = Player(1, 'Added player', 'avatar', GamingPlatform.pc);

      await playerRepo.addPlayer(addedPlayer);
      vm.onPlayerAdded(player);

      async.elapse(const Duration(milliseconds: 1));

      expect(appVM.currentPlayer, addedPlayer);
    });
  });

  test('Deleted player should be removed from the list', () {
    fakeAsync((async) async {
      final selectedPlayer = Player(0, 'player', 'avatar', GamingPlatform.xboxone);
      final otherPlayer = Player(1, 'other player', 'avatar', GamingPlatform.xboxone);
      final playerRepo = FakePlayerRepository(selectedPlayer: selectedPlayer);

      final vm = MainViewModel(selectedPlayer, playerRepo, MockAppViewModel());
      async.elapse(const Duration(milliseconds: 1));

      vm.deletePlayer(otherPlayer);
      async.elapse(const Duration(milliseconds: 1));

      expect(vm.players, [selectedPlayer]);
    });
  });

  test('Deleting current player should select another one', () {
    fakeAsync((async) async {
      final selectedPlayer = Player(0, 'player', 'avatar', GamingPlatform.xboxone);
      final otherPlayer = Player(1, 'other player', 'avatar', GamingPlatform.xboxone);
      final playerRepo = FakePlayerRepository(selectedPlayer: selectedPlayer);
      final appVM = AppViewModel(playerRepo);

      final vm = MainViewModel(selectedPlayer, playerRepo, appVM);
      async.elapse(const Duration(milliseconds: 1));

      vm.deletePlayer(selectedPlayer);
      async.elapse(const Duration(milliseconds: 1));

      expect(appVM.currentPlayer, otherPlayer);
    });
  });

  test('Deleting the only player should change the app state', () {
    fakeAsync((async) async {
      final selectedPlayer = Player(0, 'player', 'avatar', GamingPlatform.xboxone);
      final playerRepo = FakePlayerRepository(selectedPlayer: selectedPlayer);
      final appVM = AppViewModel(playerRepo);

      final vm = MainViewModel(selectedPlayer, playerRepo, appVM);
      async.elapse(const Duration(milliseconds: 1));

      vm.deletePlayer(selectedPlayer);
      async.elapse(const Duration(milliseconds: 1));

      expect(appVM.state, NoPlayerSelected());
    });
  });
}
