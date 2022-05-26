import 'package:flutter/material.dart';

class BattleStatsApp extends StatelessWidget {
  const BattleStatsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battlestats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold()
    );
  }
}

