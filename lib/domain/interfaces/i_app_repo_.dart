
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../application/core/failure/failure.dart';
import '../../data/models/scrapping_instruction.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/user.dart';

abstract class IAppRepo {
  Future<Either<Failure, SupportedStore>> getStores();
  Future<Either<Failure, ScrapInstructionResponse>> getScrappingInstruction(String store);
}
