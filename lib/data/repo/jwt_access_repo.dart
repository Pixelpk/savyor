
import 'package:savyor/common/jwt_enum.dart';
import 'package:savyor/constant/jwt_decoding/decoding.dart';
import 'package:savyor/data/local_data_source/jwt/jwt_local_access_token.dart';
import 'package:savyor/data/models/tokens_model.dart';

import '../remote_data_source/jwt_remote_access_token.dart';

class JwtAccessRepo {
  JwtAccessRepo({required this.jwtLocalAccessToken, required this.jwtRemoteAccessToken});
  JwtLocalAccessToken jwtLocalAccessToken;
  JwtRemoteAccessToken jwtRemoteAccessToken;

  Future<String?> get loadAccessToken async {
    String? accessToken;

    accessToken = await jwtLocalAccessToken.getToken(SecureStorageKeys.accessToken);
    String? refresh = await jwtLocalAccessToken.getToken(SecureStorageKeys.refreshToken);
    if (accessToken != null && !JwtDecoding.tokenHasExpired(accessToken)) {
      return accessToken;
    }
    JwtTokensModel keycloakTokenResponse = await jwtRemoteAccessToken.getTokens(refresh);
    accessToken = keycloakTokenResponse.access?.token;
    final refreshToken = keycloakTokenResponse.refresh?.token;
    if (!JwtDecoding.tokenHasExpired(accessToken) && !JwtDecoding.tokenHasExpired(refreshToken)) {
      await Future.wait(
          [jwtLocalAccessToken.saveToken(SecureStorageKeys.accessToken, accessToken!), jwtLocalAccessToken.saveToken(SecureStorageKeys.refreshToken, refreshToken!)]);

      return accessToken;
    }
    return null;
  }
}
