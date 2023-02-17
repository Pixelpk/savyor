import 'dart:io';

import 'package:dio/dio.dart';
import 'package:savyor/application/core/exception/exception.dart';
import 'package:savyor/application/network/error_handler/error_handler.dart';
import 'package:savyor/application/network/external_values/ExternalValues.dart';
import 'package:savyor/common/logger/log.dart';
import 'package:savyor/data/models/tokens_model.dart';

class JwtRemoteAccessToken {
  JwtRemoteAccessToken({required this.externalValues});

  ExternalValues externalValues;

  Future<JwtTokensModel> getTokens(String? oldRefreshToken) async {
    try {
      final res = await Dio(BaseOptions(
              baseUrl: externalValues.getBaseUrl(),
              receiveDataWhenStatusError: true,
              headers: {HttpHeaders.contentTypeHeader: "application/json"},
              connectTimeout: 60 * 1000,
              receiveTimeout: 60 * 1000))
          .post('/auth/refresh-tokens', data: {'refreshToken': oldRefreshToken});

      return JwtTokensModel.fromJson(res.data);
    } on DioError catch (e) {
      d(e.response.toString());
      final exception = getException(e);
      throw exception;
    } catch (e) {
      throw ResponseException(msg: e.toString());
    }
  }
}
