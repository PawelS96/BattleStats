import 'package:battlestats/common/utils/cast_utils.dart';

class WeaponStats {
  final String accuracy;

  final int headshotKills;
  final String headshots;
  final double hitVKills;
  final String? image;
  final int kills;
  final double killsPerMinute;
  final int shotsFired;
  final int shotsHit;
  final int timeEquipped;
  final String type;
  final String weaponName;

  WeaponStats({
    required this.accuracy,
    required this.headshotKills,
    required this.headshots,
    required this.hitVKills,
    required this.image,
    required this.kills,
    required this.killsPerMinute,
    required this.shotsFired,
    required this.shotsHit,
    required this.timeEquipped,
    required this.type,
    required this.weaponName,
  });

  factory WeaponStats.fromJson(Map<String, dynamic> json) {
    return WeaponStats(
      accuracy: castOrNull<String>(json['accuracy']) ?? '0.0%',
      headshotKills: castOrNull<int>(json['headshotKills']) ?? 0,
      headshots: castOrNull<String>(json['headshots']) ?? '0.0%',
      hitVKills: castOrNull<num>(json['hitVKills'])?.toDouble() ?? 0.0,
      image: castOrNull<String>(json['image']),
      kills: castOrNull<int>(json['kills']) ?? 0,
      killsPerMinute: castOrNull<num>(json['killsPerMinute'])?.toDouble() ?? 0.0,
      shotsFired: castOrNull<int>(json['shotsFired']) ?? 0,
      shotsHit: castOrNull<int>(json['shotsHit']) ?? 0,
      timeEquipped: castOrNull<int>(json['timeEquipped']) ?? 0,
      type: castOrNull<String>(json['type']) ?? '',
      weaponName: castOrNull<String>(json['weaponName']) ?? '',
    );
  }
}
