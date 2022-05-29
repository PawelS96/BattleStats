import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeaponHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int starCount;

  const WeaponHeader({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.starCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: 80,
        ),
        const SizedBox(height: 8),
        Text(
          name,
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
              starCount.toString(),
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
}
