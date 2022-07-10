import 'package:battlestats/common/utils/generic_utils.dart';

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
    final name = castOrNull<String>(json['weaponName']) ?? '';
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
      type: _getCorrectWeaponType(name, castOrNull<String>(json['type']) ?? ''),
      weaponName: name,
    );
  }

  static String _getCorrectWeaponType(String name, String type) {
    final lowercaseName = name.toLowerCase();
    if (lowercaseName.contains('arisaka') || lowercaseName.contains('carcano')) {
      return 'Rifle';
    }

    if (lowercaseName.contains('m1917 patrol')){
      return 'Smg';
    }
      
    return type;
  }

  int get starCount => kills ~/ 100;

  Map<String, dynamic> toJson() {
    return {
      "accuracy": accuracy,
      "headshotKills": headshotKills,
      "headshots": headshots,
      "hitVKills": hitVKills,
      "image": image,
      "kills": kills,
      "killsPerMinute": killsPerMinute,
      "shotsFired": shotsFired,
      "shotsHit": shotsHit,
      "timeEquipped": timeEquipped,
      "type": type,
      "weaponName": weaponName,
    };
  }
}
