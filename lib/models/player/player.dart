import 'package:battlestats/models/player/platform.dart';

class Player {
  final int id;
  final String name;
  final String? avatar;
  final GamingPlatform platform;

  Player(this.id, this.name, this.avatar, this.platform);

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      json['id'],
      json['userName'],
      json['avatar'],
      GamingPlatform.values.firstWhere((e) => e.name == json['platform']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': name,
      'avatar': avatar,
      'platform': platform.name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          avatar == other.avatar &&
          platform == other.platform;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ avatar.hashCode ^ platform.hashCode;
}
