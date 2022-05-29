import 'package:battlestats/models/classes/class_stats.dart';

class ClassStatsResponse {
  final int id;
  final String? username;
  final String? avatar;
  final List<ClassStats> classes;

  ClassStatsResponse(this.id, this.username, this.avatar, this.classes);

  factory ClassStatsResponse.fromJson(Map<String, dynamic> json) {
    return ClassStatsResponse(
      json['id'] as int,
      json['username'] as String?,
      json['avatar'] as String?,
      (json['classes'] as List<dynamic>)
          .map((e) => ClassStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
