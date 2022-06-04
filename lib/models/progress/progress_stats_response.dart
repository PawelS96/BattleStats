import 'package:battlestats/common/utils/generic_utils.dart';
import 'package:battlestats/models/progress/progress_stats.dart';

class ProgressStatsResponse {
  final int? id;
  final String? username;
  final String? avatar;
  final List<ProgressStats> progress;

  ProgressStatsResponse({
    required this.id,
    required this.username,
    required this.avatar,
    required this.progress,
  });

  factory ProgressStatsResponse.fromJson(Map json) {
    return ProgressStatsResponse(
      id: castOrNull<int>(json['id']),
      username: castOrNull<String>(json['username']),
      avatar: castOrNull<String>(json['avatar']),
      progress: (json['progress'] as List<dynamic>)
          .map((e) => ProgressStats.fromJson(e as Map))
          .toList(),
    );
  }
}
