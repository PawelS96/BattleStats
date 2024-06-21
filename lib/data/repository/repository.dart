mixin class Repository {
  Stream<T?> fetchAndCache<T>({
    required DataAccessType accessType,
    required Future<T?> Function() getFromCache,
    required Future<void> Function(T) saveToCache,
    required Future<T?> Function() getFromWeb,
  }) async* {
    final cachedValue = accessType == DataAccessType.onlyRemote ? null : await getFromCache();
    if (cachedValue != null) {
      yield cachedValue;
    }

    final newValue = await getFromWeb();
    if (newValue != null) {
      await saveToCache(newValue);
    }

    if (newValue != null || cachedValue == null) {
      yield newValue;
    }
  }
}

enum DataAccessType {
  localAndRemote,
  onlyRemote,
}
