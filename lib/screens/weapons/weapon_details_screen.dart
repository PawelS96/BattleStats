import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/common/utils/ui_utils.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/common/widgets/stats_text.dart';
import 'package:battlestats/common/widgets/weapon_header.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';
import 'package:flutter/material.dart';

class WeaponDetailsScreen extends StatelessWidget {
  final WeaponStats weaponStats;

  const WeaponDetailsScreen({Key? key, required this.weaponStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;
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
                      _kpmStats(),
                      _timeStats(),
                      _accuracyStats(),
                      _shotsFiredStats(),
                      _shotsHitStats(),
                      _headshotStats(),
                      _headshotKillsStats(),
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
      imageUrl: weaponStats.image ?? '',
      name: weaponStats.weaponName,
      starCount: weaponStats.starCount,
    );
  }

  Widget _killStats() {
    return StatsText(
      title: 'KILLS',
      value: weaponStats.kills.toString(),
    );
  }

  Widget _kpmStats() {
    return StatsText(
      title: 'KPM',
      value: weaponStats.killsPerMinute.toString(),
    );
  }

  Widget _timeStats() {
    return StatsText(
      title: 'TIME',
      value: formatTime(weaponStats.timeEquipped * 1000),
    );
  }

  Widget _accuracyStats() {
    return StatsText(
      title: 'ACCURACY',
      value: weaponStats.accuracy,
    );
  }

  Widget _shotsFiredStats() {
    return StatsText(
      title: 'SHOTS FIRED',
      value: weaponStats.shotsFired.toString(),
    );
  }

  Widget _shotsHitStats() {
    return StatsText(
      title: 'SHOTS HIT',
      value: weaponStats.shotsHit.toString(),
    );
  }

  Widget _headshotStats() {
    return StatsText(
      title: 'HEADSHOTS',
      value: weaponStats.headshots,
    );
  }

  Widget _headshotKillsStats() {
    return StatsText(
      title: 'HEADSHOT KILLS',
      value: weaponStats.headshotKills.toString(),
    );
  }
}
