import 'package:battlestats/common/contants/app_colors.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/stats_text.dart';
import 'package:battlestats/screens/game_modes/game_modes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameModesScreen extends StatelessWidget {
  const GameModesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('GAME MODES'),
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          Consumer<GameModesViewModel>(
            builder: (ctx, vm, _) {
              return vm.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SafeArea(
                      child: RefreshIndicator(
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
                                    crossAxisCount: isLandscape ? 4 : 2,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                  ),
                                  delegate: SliverChildListDelegate(
                                    [
                                      StatsText(
                                        title: 'Score',
                                        value: stats.score.toString(),
                                      ),
                                      StatsText(
                                        title: 'Wins',
                                        value: stats.wins.toString(),
                                      ),
                                      StatsText(
                                        title: 'Loses',
                                        value: stats.losses.toString(),
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
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
