import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheSecureStorage {
  static final secureStorage = const FlutterSecureStorage();
// get - set - delete
//store data => (key , value)
//stored data is encrypted

  static Future<void> setUserToken(
      {required String key, required String value}) async {
    return await secureStorage.write(key: key, value: value);
  }

  static Future<String> getUserToken({required String key}) async {
    return await secureStorage.read(key: key) ?? "";
  }

  static Future<void> deleteUserToken({required String key}) async {
    return await secureStorage.delete(key: key);
  }
}
