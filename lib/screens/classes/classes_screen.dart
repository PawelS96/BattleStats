import 'package:battlestats/common/contants/app_colors.dart';
import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/retry_button.dart';
import 'package:battlestats/common/widgets/stats_text.dart';
import 'package:battlestats/screens/classes/classes_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Classes'),
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Consumer<ClassesViewModel>(
              builder: (ctx, vm, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (vm.classes.isEmpty) {
                  return Center(
                    child: RetryButton(onClick: vm.retry),
                  );
                }

                return RefreshIndicator(
                  onRefresh: vm.refresh,
                  child: CustomScrollView(
                    slivers: [
                      for (var stats in vm.classes) ...[
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              CachedNetworkImage(
                                imageUrl: stats.image,
                                width: 100,
                                height: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 30),
                                child: Text(
                                  stats.name,
                                  style:
                                      const TextStyle(color: AppColors.textPrimary, fontSize: 24),
                                ),
                              ),
                            ],
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
                                  title: 'Kills',
                                  value: stats.kills.toString(),
                                ),
                                StatsText(
                                  title: 'Time',
                                  value: formatTime(stats.secondsPlayed * 1000),
                                ),
                                StatsText(
                                  title: 'KPM',
                                  value: stats.kpm.toString(),
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
          )
        ],
      ),
    );
  }
}
