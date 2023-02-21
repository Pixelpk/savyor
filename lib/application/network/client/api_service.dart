import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:savyor/application/network/client/iApService.dart';
import 'package:savyor/application/network/external_values/iExternalValue.dart';
import 'package:savyor/common/logger/log.dart';
import 'package:savyor/data/local_data_source/preference/i_pref_helper.dart';
import 'package:savyor/data/repo/jwt_access_repo.dart';

import '../../../di/di.dart';

class ApiService extends Interceptor implements IApiService {
  ApiService.create({required IExternalValues externalValues}) {
    serviceGenerator(externalValues);
  }

  bool _isTokenRequired = false;

  @override
  Dio get() => _dio;

  @override
  BaseOptions getBaseOptions(IExternalValues externalValues) {
    return BaseOptions(
        baseUrl: externalValues.getBaseUrl(),
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000);
  }

  @override
  HttpClient httpClientCreate(HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }

  @override
  void serviceGenerator(IExternalValues externalValues) {
    _dio = Dio(getBaseOptions(externalValues));
    _dio.interceptors.add(this);

    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = httpClientCreate;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    d("onRequest Headers: ${options.headers}");
    d("onRequest Body: ${options.data}");
    if (_isTokenRequired) {
      final token = inject<IPrefHelper>().retrieveToken();
      if (token != null) {
        options.headers.addAll({"x-access-token": token});
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    d("RESPONSE ${response.data}");
    d("RESPONSE-StatusCode ${response.statusCode}");
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }

  late Dio _dio;

  @override
  void setIsTokenRequired(bool value) {
    _isTokenRequired = value;
  }

  @override
  void enableLogger(bool value) {
    if (value) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, compact: false));
    }
  }
}
