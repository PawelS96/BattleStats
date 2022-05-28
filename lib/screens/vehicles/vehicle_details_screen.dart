import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:battlestats/common/widgets/background_image.dart';
import 'package:battlestats/models/vehicles/vehicle_stats.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BackgroundImage(),
          SafeArea(
            child: isLandscape ? _landscapeLayout() : _portraitLayout(),
          ),
        ],
      ),
    );
  }

  Widget _portraitLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          _imageAndName(),
          const SizedBox(height: 60),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  _killStats(),
                  const SizedBox(height: 30),
                  _kpmStats(),
                ],
              ),
              const SizedBox(width: 100),
              Column(
                children: [
                  _destroyedStats(),
                  const SizedBox(height: 30),
                  _timeStats(),

                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _landscapeLayout() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(child: _imageAndName()),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _killStats(),
            _destroyedStats(),
            _kpmStats(),
            _timeStats(),
          ],
        ),
      ],
    );
  }

  Widget _imageAndName() {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: vehicleStats.image ?? '',
          height: 80,
        ),
        const SizedBox(height: 8),
        Text(
          vehicleStats.formattedName,
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
              (vehicleStats.kills ~/ 100).toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _killStats() {
    return _statsText(
      title: 'KILLS',
      value: vehicleStats.kills.toString(),
    );
  }

  Widget _destroyedStats() {
    return _statsText(
      title: 'DESTROYED',
      value: vehicleStats.destroyed.toString(),
    );
  }

  Widget _kpmStats() {
    return _statsText(
      title: 'KPM',
      value: vehicleStats.killsPerMinute.toString(),
    );
  }

  Widget _timeStats() {
    return _statsText(
      title: 'TIME',
      value: formatTime(vehicleStats.timeIn * 1000),
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
