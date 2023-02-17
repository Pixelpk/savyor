import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:savyor/common/jwt_enum.dart';
import 'package:savyor/constant/jwt_decoding/decoding.dart';

class JwtLocalAccessToken {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getToken(SecureStorageKeys key) async {
    return (await _storage.read(
        key: key.name,
        iOptions: const IOSOptions(accountName: 'mindshift_secure_storage_service'),
        aOptions: const AndroidOptions(encryptedSharedPreferences: true)));
  }

  Future<void> saveToken(SecureStorageKeys key, String value) async {
    (await _storage.write(
        key: key.name,
        value: value,
        iOptions: const IOSOptions(accountName: 'mindshift_secure_storage_service'),
        aOptions: const AndroidOptions(encryptedSharedPreferences: true)));
  }

  Future<void> deleteToken() async {
    const iOptions = IOSOptions(accountName: 'mindshift_secure_storage_service');
    const aOptions = AndroidOptions(encryptedSharedPreferences: true);

    Future.wait([
      _storage.delete(key: SecureStorageKeys.accessToken.name, iOptions: iOptions, aOptions: aOptions),
      _storage.delete(key: SecureStorageKeys.refreshToken.name, iOptions: iOptions, aOptions: aOptions)
    ]);
  }

  Future<bool> checkToken() async {
    final token = (await getToken(SecureStorageKeys.accessToken));
    return token != null && !JwtDecoding.tokenHasExpired(token);
  }
}
