import 'package:battlestats/models/player/player_stats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Missing or invalid JSON fields should be replaced with nulls', () {
    final json = {
      'avatar': 'url',
      'userName': 'name',
      'id': 'stringInsteadOfInt',
    };

    final stats = PlayerStats.fromJson(json);

    expect(stats.avatar, 'url');
    expect(stats.userName, 'name');
    expect(stats.id, null);
  });
}
