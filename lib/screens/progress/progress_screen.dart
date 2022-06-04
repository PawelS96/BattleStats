import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/retry_button.dart';
import 'package:battlestats/common/widgets/stats_text.dart';
import 'package:battlestats/models/progress/progress_stats.dart';
import 'package:battlestats/screens/progress/progress_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Consumer<ProgressViewModel>(
              builder: (ctx, vm, _) {
                if (vm.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (vm.progress.isEmpty) {
                  return Center(
                    child: RetryButton(onClick: vm.retry),
                  );
                }

                return LayoutBuilder(
                  builder: (ctx, constraints) {
                    return RefreshIndicator(
                      onRefresh: vm.refresh,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                            minWidth: constraints.maxWidth,
                          ),
                          child: isLandscape
                              ? Center(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: vm.progress.map(_listItem).toList(),
                                ))
                              : IntrinsicHeight(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: vm.progress.map(_listItem).toList(),
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _listItem(ProgressStats progress) {
    return StatsText(
      title: progress.name,
      value: '${progress.current} / ${progress.total}',
    );
  }
}
