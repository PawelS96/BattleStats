import 'dart:async';

import 'package:battlestats/app/app_viewmodel.dart';
import 'package:battlestats/common/contants/app_colors.dart';
import 'package:battlestats/common/utils/ui_utils.dart';
import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/nav_button.dart';
import 'package:battlestats/common/widgets/retry_button.dart';
import 'package:battlestats/common/widgets/stats_text.dart';
import 'package:battlestats/models/player/player.dart';
import 'package:battlestats/models/player/player_stats.dart';
import 'package:battlestats/screens/add_player/add_player_screen.dart';
import 'package:battlestats/screens/classes/classes_screen.dart';
import 'package:battlestats/screens/classes/classes_viewmodel.dart';
import 'package:battlestats/screens/detailed_stats/detailed_stats_screen.dart';
import 'package:battlestats/screens/game_modes/game_,modes_screen.dart';
import 'package:battlestats/screens/game_modes/game_modes_viewmodel.dart';
import 'package:battlestats/screens/main/main_viewmodel.dart';
import 'package:battlestats/screens/main/player_list_item.dart';
import 'package:battlestats/screens/progress/progress_screen.dart';
import 'package:battlestats/screens/progress/progress_viewmodel.dart';
import 'package:battlestats/screens/vehicles/vehicles_screen.dart';
import 'package:battlestats/screens/vehicles/vehicles_viewmodel.dart';
import 'package:battlestats/screens/weapons/weapons_screen.dart';
import 'package:battlestats/screens/weapons/weapons_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final Player player;

  const MainScreen({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainViewModel vm;
  late WeaponsViewModel weaponsVM;
  late VehiclesViewModel vehiclesVM;
  late ClassesViewModel classesVM;
  late GameModesViewModel gameModesVM;
  late ProgressViewModel progressVM;

  late StreamSubscription<String> errorSub;

  @override
  void initState() {
    super.initState();
    vm = MainViewModel.of(context, widget.player);
    weaponsVM = WeaponsViewModel.of(context, widget.player);
    vehiclesVM = VehiclesViewModel.of(context, widget.player);
    classesVM = ClassesViewModel.of(context, widget.player);
    gameModesVM = GameModesViewModel.of(context, widget.player);
    progressVM = ProgressViewModel.of(context, widget.player);

    errorSub = vm.errors.listen((msg) => showSnackBarMessage(context, msg));
  }

  @override
  void dispose() {
    errorSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<MainViewModel>(
        builder: (ctx, vm, _) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              const BackgroundImage(),
              SafeArea(top: false, child: _content(vm)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _navButtons(PlayerStats stats) {
    return [
      NavButton(
        text: 'Detailed stats',
        onClick: () => _showDetailedStats(stats),
      ),
      NavButton(
        text: 'Weapons',
        onClick: _showWeapons,
      ),
      NavButton(
        text: 'Vehicles',
        onClick: _showVehicles,
      ),
      NavButton(
        text: 'Classes',
        onClick: _showClasses,
      ),
      NavButton(
        text: 'Game modes',
        onClick: _showGameModes,
      ),
      NavButton(
        text: 'Progress',
        onClick: _showProgress,
      ),
    ];
  }

  Widget _content(MainViewModel vm) {
    if (vm.isLoading) {
      return SizedBox.expand(
        child: Column(
          children: [
            _header(),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      );
    }

    final stats = vm.stats;

    if (stats == null) {
      return SizedBox.expand(
        child: Column(
          children: [
            _header(),
            const Spacer(),
            RetryButton(onClick: vm.retry),
            const Spacer(),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: vm.refresh,
      child: SizedBox.expand(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _header(),
              _stats(stats),
              ..._navButtons(stats),
            ],
          ),
        ),
      ),
    );
  }

  Widget _changePlayerButton() {
    return MaterialButton(
      onPressed: _showPlayerList,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 2, color: AppColors.textPrimary),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Text(
        "Change player",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageBuilder: (ctx, image) => CircleAvatar(backgroundImage: image, radius: 50),
            placeholder: (_, __) => const SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
            imageUrl: widget.player.avatar ?? '',
            errorWidget: (ctx, _, __) => Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 80,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: const BorderRadius.all(Radius.circular(75)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.player.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        _changePlayerButton(),
      ],
    );
  }

  Widget _stats(PlayerStats stats) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _statsText(title: 'SCORE/MIN', value: stats.scorePerMinute?.toInt() ?? 0),
                _statsText(title: 'WINS', value: stats.winPercent ?? '0%'),
                _statsText(title: 'KILLS', value: stats.kills ?? 0),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _statsText(title: 'KILLS/MIN', value: stats.killsPerMinute ?? 0),
                _statsText(title: 'TIME', value: formatTime((stats.secondsPlayed ?? 0) * 1000)),
                _statsText(title: 'DEATHS', value: stats.deaths ?? 0),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _statsText({
    required String title,
    required dynamic value,
  }) {
    return Flexible(child: StatsText(title: title, value: value.toString()));
  }

  void _showDetailedStats(PlayerStats stats) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => DetailedStatsScreen(stats: stats),
      ),
    );
  }

  void _showWeapons() {
    weaponsVM.refresh();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider.value(
          value: weaponsVM,
          child: const WeaponsScreen(),
        ),
      ),
    );
  }

  void _showVehicles() {
    vehiclesVM.refresh();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider.value(
          value: vehiclesVM,
          child: const VehiclesScreen(),
        ),
      ),
    );
  }

  void _showClasses() {
    classesVM.refresh();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider.value(
          value: classesVM,
          child: const ClassesScreen(),
        ),
      ),
    );
  }

  void _showGameModes() {
    gameModesVM.refresh();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider.value(
          value: gameModesVM,
          child: const GameModesScreen(),
        ),
      ),
    );
  }

  void _showProgress() {
    progressVM.refresh();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider.value(
          value: progressVM,
          child: const ProgressScreen(),
        ),
      ),
    );
  }


  void _showAddPlayer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddPlayerScreen(
          onAdded: (player) {
            Navigator.pop(context);
            vm.onPlayerAdded(player);
          },
          showKeyboard: true,
        ),
      ),
    );
  }

  void _showPlayerList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (sheetContext) {
        final appVM = sheetContext.watch<AppViewModel>();
        return ChangeNotifierProvider.value(
          value: vm,
          child: Consumer<MainViewModel>(
            builder: (ctx, vm, _) => SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    AddPlayerListItem(
                      onClick: () {
                        Navigator.pop(sheetContext);
                        _showAddPlayer();
                      },
                    ),
                    for (var player in vm.players)
                      PlayerListItem(
                        player: player,
                        isSelected: player == appVM.currentPlayer,
                        onClick: (player) {
                          Navigator.pop(sheetContext);
                          vm.selectPlayer(player);
                        },
                        onClickDelete: (player) {
                          if (vm.players.length == 1) {
                            Navigator.pop(sheetContext);
                          }
                          vm.deletePlayer(player);
                        },
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
