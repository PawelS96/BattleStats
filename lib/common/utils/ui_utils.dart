import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

extension BuildContextExt on BuildContext {
  bool get isLandscape {
    final screenSize = MediaQuery.of(this).size;
    return screenSize.width > screenSize.height;
  }
}
