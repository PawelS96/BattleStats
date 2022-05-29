import 'package:battlestats/common/utils/cast_utils.dart';

class ClassStats {
  final String name;
  final int score;
  final int kills;
  final double kpm;
  final String image;
  final int secondsPlayed;

  ClassStats({
    required this.name,
    required this.score,
    required this.kills,
    required this.kpm,
    required this.image,
    required this.secondsPlayed,
  });

  factory ClassStats.fromJson(Map<String, dynamic> json) {
    return ClassStats(
      name: json['className'] as String,
      score: castOrNull<int>(json['score']) ?? 0,
      kills: castOrNull<int>(json['kills']) ?? 0,
      kpm: castOrNull<num>(json['kpm'])?.toDouble() ?? 0.0,
      image: castOrNull<String>(json['image']) ?? '',
      secondsPlayed: castOrNull<int>(json['secondsPlayed']) ?? 0,
    );
  }
}
