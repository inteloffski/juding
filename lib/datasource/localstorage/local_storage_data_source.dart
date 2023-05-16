abstract class LocalStorageDataSource {

  Future<String> readSidFromLocalStorage(String key);

  Future<void> writeSeedToLocalStorage(String key, String value);

  Future<bool> containsKeyToLocalStorage(String key);

  Future<void> clearLocalStorage();
}