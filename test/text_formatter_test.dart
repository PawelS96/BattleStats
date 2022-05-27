import 'package:battlestats/common/utils/text_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should format duration correctly', () {
    final durations = {
      '0m': Duration.zero,
      '32m': const Duration(minutes: 32),
      '2h 30m': const Duration(hours: 2, minutes: 30),
    };

    durations.forEach((key, value) {
      expect(formatTime(value.inMilliseconds), key);
    });
  });
}
