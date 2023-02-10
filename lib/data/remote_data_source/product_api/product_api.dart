import 'package:dio/dio.dart';
import 'package:savyor/data/models/active_product.dart';
import 'package:savyor/data/models/supported_store.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/data/models/user.dart';

import '../../../../application/core/exception/exception.dart';
import '../../../../application/network/client/iApService.dart';
import '../../../../application/network/error_handler/error_handler.dart';
import '../../../../common/logger/log.dart';
import 'i_product_api.dart';

class ProductApi implements IProductApi {
  ProductApi(IApiService api) {
    api.setIsTokenRequired(true);
    dio = api.get();
  }
  late Dio dio;

  @override
  Future<ActiveProduct> getActiveProducts() async {
    try {
      final responseData = await dio.get("/api/product/active");
      return ActiveProduct.fromJson(responseData.data);
    } on DioError catch (e) {
      d(e);
      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      d(e);
      throw ResponseException(msg: e.toString());
    }
  }

  @override
  Future<ServerResponse> trackProduct(Map<String, dynamic> data) async {
    try {
      final Dio webHookDio = Dio();
      final responseData = await webHookDio.post("http://3.144.165.4:6000/track", data: data);

      // final responseData = await webHookDio.post("http://192.168.18.20:6000/track", data: data);
      d("Status  ${responseData.statusCode}");
      d("RESPONSE ${responseData.data}");
      final res = ServerResponse.fromJson(responseData.data);
      if (res.error != null && !res.error!) {
        return res;
      }
      throw res;
    } on DioError catch (e) {
      d(e);
      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      d(e);
      if (e.runtimeType == ServerResponse) {
        throw ResponseException(msg: (e as ServerResponse).msg!,code:(e).code ?? 0 );
      }
      throw ResponseException(msg: e.toString());
    }
  }

  @override
  Future<ServerResponse> updateProduct(Map<String, dynamic> data) async {
    try {
      final responseData = await dio.put("/api/user/userinput",data: data);
      final res = ServerResponse.fromJson(responseData.data);
      if (res.error != null && !res.error!) {
        return res;
      }
      throw res;
    } on DioError catch (e) {
      d(e);
      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      d(e);
      if (e.runtimeType == ServerResponse) {
        throw ResponseException(msg: (e as ServerResponse).msg!);
      }
      throw ResponseException(msg: e.toString());
    }
  }
}
