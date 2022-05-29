import 'package:battlestats/data/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Access type - local and remote
  test('Both local and remote data are available, should emit both and save data to local cache',
      () async {
    final repo = Repository();
    int cachedValue = 0;
    int remoteValue = 1;

    final stream = repo.fetchAndCache<int>(
      accessType: DataAccessType.localAndRemote,
      getFromCache: () => Future.value(cachedValue),
      saveToCache: (val) async {
        cachedValue = val;
      },
      getFromWeb: () => Future.value(remoteValue),
    );

    await expectLater(stream, emitsInOrder([cachedValue, remoteValue]));
    expect(cachedValue, remoteValue);
  });

  test('Only remote data is available, should emit it and save to local cache', () async {
    final repo = Repository();
    int? cachedValue;
    int remoteValue = 1;

    final stream = repo.fetchAndCache<int>(
      accessType: DataAccessType.localAndRemote,
      getFromCache: () => Future.value(cachedValue),
      saveToCache: (val) async {
        cachedValue = val;
      },
      getFromWeb: () => Future.value(remoteValue),
    );

    await expectLater(stream, emitsInOrder([remoteValue]));
    expect(cachedValue, remoteValue);
  });

  test('Only local data is available, should emit it', () async {
    final repo = Repository();
    int cachedValue = 1;
    int? remoteValue;

    final stream = repo.fetchAndCache<int>(
      accessType: DataAccessType.localAndRemote,
      getFromCache: () => Future.value(cachedValue),
      saveToCache: (val) async {
        cachedValue = val;
      },
      getFromWeb: () => Future.value(remoteValue),
    );

    await expectLater(stream, emitsInOrder([cachedValue]));
    expect(cachedValue, cachedValue);
  });

  test('No data available, should emit null', () async {
    final repo = Repository();
    int? cachedValue;
    int? remoteValue;

    final stream = repo.fetchAndCache<int>(
      accessType: DataAccessType.localAndRemote,
      getFromCache: () => Future.value(cachedValue),
      saveToCache: (val) async {
        cachedValue = val;
      },
      getFromWeb: () => Future.value(remoteValue),
    );

    await expectLater(stream, emitsInOrder([null]));
    expect(cachedValue, cachedValue);
  });

  // Access type - only remote
  test('Both data available, should emit remote data and save to local cache', () async {
    final repo = Repository();
    int cachedValue = 0;
    int remoteValue = 1;

    final stream = repo.fetchAndCache<int>(
      accessType: DataAccessType.onlyRemote,
      getFromCache: () => Future.value(cachedValue),
      saveToCache: (val) async {
        cachedValue = val;
      },
      getFromWeb: () => Future.value(remoteValue),
    );

    await expectLater(stream, emitsInOrder([remoteValue]));
    expect(cachedValue, remoteValue);
  });

  test('Only local data available, should emit null', () async {
    final repo = Repository();
    int cachedValue = 0;
    int? remoteValue;

    final stream = repo.fetchAndCache<int>(
      accessType: DataAccessType.onlyRemote,
      getFromCache: () => Future.value(cachedValue),
      saveToCache: (val) async {
        cachedValue = val;
      },
      getFromWeb: () => Future.value(remoteValue),
    );

    await expectLater(stream, emitsInOrder([null]));
    expect(cachedValue, cachedValue);
  });
}
