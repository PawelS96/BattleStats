import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
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
