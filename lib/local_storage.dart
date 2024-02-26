import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> writeData(String data, String key) async {
    await storage.write(key: key, value: data);
  }

  Future<String> getData(String key) async {
    return await storage.read(key: key) ?? '';
  }

  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }
}
