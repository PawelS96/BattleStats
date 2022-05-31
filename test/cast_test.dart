import 'package:battlestats/common/utils/generic_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return null', () {
    dynamic string = 'text';
    expect(castOrNull<int>(string), null);

    int number = 1;
    expect(castOrNull<bool>(number), null);
  });

  test('Should return the value', () {
    dynamic string = 'text';
    expect(castOrNull<String>(string), 'text');

    dynamic list = [1, 2];
    expect(castOrNull<List<int>>(list), [1, 2]);

    int? nullableNumber = 1;
    expect(castOrNull<int?>(nullableNumber), 1);
    expect(castOrNull<int>(nullableNumber), 1);
  });
}
