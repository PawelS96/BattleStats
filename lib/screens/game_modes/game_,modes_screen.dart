import 'package:battlestats/common/contants/app_colors.dart';
import 'package:battlestats/common/utils/ui_utils.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/retry_button.dart';
import 'package:battlestats/common/widgets/stats_text.dart';
import 'package:battlestats/screens/game_modes/game_modes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameModesScreen extends StatelessWidget {
  const GameModesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Game Modes'),
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Consumer<GameModesViewModel>(
              builder: (ctx, vm, _) {
                if (vm.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (vm.gameModes.isEmpty) {
                  return Center(child: RetryButton(onClick: vm.retry));
                }

                return RefreshIndicator(
                  onRefresh: vm.refresh,
                  child: CustomScrollView(
                    slivers: [
                      for (var stats in vm.gameModes) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 30),
                            child: Center(
                              child: Text(
                                stats.gameModeName,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverGrid(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 90,
                              crossAxisCount: context.isLandscape ? 4 : 2,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            ),
                            delegate: SliverChildListDelegate(
                              [
                                StatsText(
                                  title: 'Score',
                                  value: (stats.score ?? 0).toString(),
                                ),
                                StatsText(
                                  title: 'Wins',
                                  value: (stats.wins ?? 0).toString(),
                                ),
                                StatsText(
                                  title: 'Loses',
                                  value: (stats.losses ?? 0).toString(),
                                ),
                                StatsText(
                                  title: 'Win percentage',
                                  value: stats.winPercent ?? '0.0%',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
