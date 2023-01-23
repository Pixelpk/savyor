import 'package:dio/dio.dart';
import 'package:savyor/application/core/exception/exception.dart';
import 'package:savyor/application/network/client/iApService.dart';
import 'package:savyor/application/network/error_handler/error_handler.dart';
import 'package:savyor/ui/browser/model/data_parser.dart';

class UrlApi {
  IApiService iApiService;
  late Dio _dio;

  UrlApi({required this.iApiService}) {
    iApiService.setIsTokenRequired(false);
    iApiService.enableLogger(false);
    _dio = iApiService.get();
  }

  Future<Parser> load(String url) async {
    try {
      final res = await _dio.get(url);
      return Parser(res.data);
    } on DioError catch (e) {
      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      throw ResponseException(msg: e.toString());
    }
  }
}