
import 'package:dio/dio.dart';
import 'package:savyor/data/models/user.dart';

import '../../models/scrapping_instruction.dart';
import '../../models/supported_store.dart';


abstract class IAppApi {
  Future<SupportedStore> getStores();

  Future<ScrapInstructionResponse> getScrappingInstruction(String store);
}
