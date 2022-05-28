import 'package:battlestats/models/weapons/weapon_stats.dart';

class WeaponStatsResponse {
  final int id;
  final String? username;
  final String? avatar;
  final List<WeaponStats> weapons;

  WeaponStatsResponse(this.id, this.username, this.avatar, this.weapons);

  factory WeaponStatsResponse.fromJson(Map<String, dynamic> json) {
    return WeaponStatsResponse(
      json['id'] as int,
      json['username'] as String?,
      json['avatar'] as String?,
      (json['weapons'] as List<dynamic>)
          .map((e) => WeaponStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
