import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final longestSide = MediaQuery.of(context).size.longestSide;
    final blurSigma = longestSide / 75 + (longestSide - 800).abs() / 75;
    return Stack(
      children: [
        ClipRRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: blurSigma,
              sigmaY: blurSigma,
              tileMode: TileMode.mirror,
            ),
            child: SizedBox.expand(
              child: Image.asset(
                'assets/images/battlefield.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox.expand(
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
