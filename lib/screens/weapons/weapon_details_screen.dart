import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/models/weapons/weapon_stats.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeaponDetailsScreen extends StatelessWidget {
  final WeaponStats weaponStats;

  const WeaponDetailsScreen({Key? key, required this.weaponStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isLandscape) const SizedBox(height: 50),
                  CachedNetworkImage(
                    imageUrl: weaponStats.image ?? '',
                    height: 80,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weaponStats.weaponName,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        (weaponStats.kills ~/ 100).toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statsText(
                        title: 'KILLS',
                        value: weaponStats.kills.toString(),
                      ),
                      _statsText(
                        title: 'KPM',
                        value: weaponStats.killsPerMinute.toString(),
                      ),
                      _statsText(
                        title: 'TIME',
                        value: formatTime(weaponStats.timeEquipped * 1000),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statsText(title: 'ACCURACY', value: weaponStats.accuracy),
                      _statsText(
                        title: 'SHOTS FIRED',
                        value: weaponStats.shotsFired.toString(),
                      ),
                      _statsText(
                        title: 'SHOTS HIT',
                        value: weaponStats.shotsHit.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statsText(title: 'HEADSHOTS', value: weaponStats.headshots),
                      _statsText(
                        title: 'HEADSHOT KILLS',
                        value: weaponStats.headshotKills.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsText({
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        // TODO long text
        FittedBox(
          child: Text(
            value,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
