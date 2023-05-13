import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_data_source.dart';

class LocalStorageDataSourceImpl implements LocalStorageDataSource {

  final String _keyIsNotFirstEnter = "isNotFirstEnter";
  final FlutterSecureStorage storage;
  final SharedPreferences prefs;
  bool isNotRegisterWallet = false;

  LocalStorageDataSourceImpl({required this.storage, required this.prefs});

  @override
  Future<void> writeSeedToLocalStorage(String key, String value) async {
    prefs.setBool(_keyIsNotFirstEnter, isNotRegisterWallet = true);
    await storage.write(key: key, value: value);
  }

  @override
  Future<String> readSidFromLocalStorage(String key) async {
    String? values = await storage.read(key: key);
    return values ?? "";
  }

  @override
  Future<bool> containsKeyToLocalStorage(String key) async {
    if (await storage.read(key: key) != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> clearLocalStorage() {
    return storage.deleteAll();
  }
}
