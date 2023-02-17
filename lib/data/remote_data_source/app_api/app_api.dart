import 'package:dio/dio.dart';
import 'package:savyor/data/models/scrapping_instruction.dart';
import 'package:savyor/data/models/supported_store.dart';
import 'package:savyor/data/models/user.dart';

import '../../../../application/core/exception/exception.dart';
import '../../../../application/network/client/iApService.dart';
import '../../../../application/network/error_handler/error_handler.dart';
import '../../../../common/logger/log.dart';
import 'i_app_api.dart';

class AppApi implements IAppApi {
  AppApi(IApiService api) {
    api.setIsTokenRequired(true);
    dio = api.get();
  }

  late Dio dio;

  @override
  Future<SupportedStore> getStores() async {
    try {
      final responseData = await dio.get("/api/stores/getSupportedStores");
      return SupportedStore.fromJson(responseData.data);
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
  Future<ScrapInstructionResponse> getScrappingInstruction(String store) async {
    try {
      Dio dio1 = Dio();
      final responseData = await dio1.post("http://savyor.co:83/api/getsite", data: {"url": store});
      return ScrapInstructionResponse.fromJson(responseData.data);
    } on DioError catch (e) {
      d(e);
      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      d(e);
      throw ResponseException(msg: e.toString());
    }
  }
}
