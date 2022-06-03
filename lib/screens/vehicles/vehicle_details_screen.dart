import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/stats_text.dart';
import 'package:battlestats/common/widgets/weapon_header.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final VehicleStats vehicleStats;

  const VehicleDetailsScreen({Key? key, required this.vehicleStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
              child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: isLandscape ? 0 : 50, bottom: 60),
                  child: _imageAndName(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 90,
                    crossAxisCount: isLandscape ? 4 : 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  delegate: SliverChildListDelegate(
                    [
                      _killStats(),
                      _destroyedStats(),
                      _kpmStats(),
                      _timeStats(),
                    ],
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 20.0),
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget _imageAndName() {
    return WeaponHeader(
      imageUrl: vehicleStats.image ?? '',
      name: vehicleStats.formattedName,
      starCount: vehicleStats.starCount,
    );
  }

  Widget _killStats() {
    return StatsText(
      title: 'KILLS',
      value: vehicleStats.kills.toString(),
    );
  }

  Widget _destroyedStats() {
    return StatsText(
      title: 'DESTROYED',
      value: vehicleStats.destroyed.toString(),
    );
  }

  Widget _kpmStats() {
    return StatsText(
      title: 'KPM',
      value: vehicleStats.killsPerMinute.toString(),
    );
  }

  Widget _timeStats() {
    return StatsText(
      title: 'TIME',
      value: formatTime(vehicleStats.timeIn * 1000),
    );
  }
}
