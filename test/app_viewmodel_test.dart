import 'package:battlestats/app/app_state.dart';
import 'package:battlestats/app/app_viewmodel.dart';
import 'package:battlestats/models/player/platform.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'common/fakes.dart';
import 'common/mocks.dart';

void main() {
  test('Should set the correct initial state', () {
    final repo = MockPlayerRepo();
    when(() => repo.getSelectedPlayer()).thenAnswer((_) => Future.value(null));
    final vm = AppViewModel(repo);
    expect(vm.state is InitialLoading, true);
  });

  test('Should set the correct state when theres a player selected', () {
    fakeAsync((async) {
      final repo = MockPlayerRepo();
      final player = Player(0, 'name', 'avatar', GamingPlatform.pc);
      when(() => repo.getSelectedPlayer()).thenAnswer((_) => Future.value(player));
      final vm = AppViewModel(repo);
      async.elapse(const Duration(seconds: 1));
      expect(vm.state, AppState.playerSelected(player));
      expect(vm.currentPlayer, player);
    });
  });

  test('Should set the correct state when theres no player selected', () {
    fakeAsync((async) {
      final repo = MockPlayerRepo();
      when(() => repo.getSelectedPlayer()).thenAnswer((_) => Future.value(null));
      final vm = AppViewModel(repo);
      async.elapse(const Duration(seconds: 1));
      expect(vm.state is NoPlayerSelected, true);
      expect(vm.currentPlayer, null);
    });
  });

  test('Should set the correct state after changing the player', () {
    fakeAsync((async) {
      final playerToSelect = Player(0, 'name', 'avatar', GamingPlatform.pc);
      final repo = FakePlayerRepository(selectedPlayer: null);
      final vm = AppViewModel(repo);
      async.elapse(const Duration(milliseconds: 1));
      vm.changePlayer(playerToSelect);
      async.elapse(const Duration(milliseconds: 1));
      expect(vm.state, PlayerSelected(playerToSelect));
      expect(vm.currentPlayer, playerToSelect);
    });
  });
}
