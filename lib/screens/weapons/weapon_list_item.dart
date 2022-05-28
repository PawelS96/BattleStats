import 'package:battlestats/models/weapons/weapon_stats.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../common/utils/text_formatter.dart';

class WeaponListItem extends StatelessWidget {
  final WeaponStats weaponStats;
  final Function(WeaponStats) onClick;

  const WeaponListItem({
    Key? key,
    required this.weaponStats,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 15, color: Colors.white);
    return MaterialButton(
      onPressed: () => onClick(weaponStats),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: weaponStats.image ?? '',
                    errorWidget: (ctx, url, _) => Container(
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    weaponStats.weaponName,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                weaponStats.kills.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                weaponStats.killsPerMinute.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                formatTime(weaponStats.timeEquipped * 1000),
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
