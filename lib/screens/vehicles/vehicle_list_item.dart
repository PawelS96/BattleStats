import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VehicleListItem extends StatelessWidget {
  final VehicleStats vehicleStats;
  final Function(VehicleStats) onClick;

  const VehicleListItem({
    Key? key,
    required this.vehicleStats,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 15, color: Colors.white);
    return MaterialButton(
      onPressed: () => onClick(vehicleStats),
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
                    imageUrl: vehicleStats.image ?? '',
                    errorWidget: (ctx, url, _) => Container(
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    vehicleStats.formattedName,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                vehicleStats.kills.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                vehicleStats.killsPerMinute.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                formatTime(vehicleStats.timeIn * 1000),
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
