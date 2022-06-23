import 'dart:io';

import 'package:battlestats/app/app.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: await _getNavBarColor(),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);

  runApp(const BattleStatsApp());
}

Future<Color> _getNavBarColor() async {
  var color = Colors.transparent;
  if (Platform.isAndroid) {
    final info = await DeviceInfoPlugin().androidInfo;
    final version = info.version.sdkInt ?? 0;
    if (version >= 31) {
      return Colors.black;
    }
  }

  return color;
}
