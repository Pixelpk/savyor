import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:savyor/data/models/scrapping_instruction.dart';
import 'package:savyor/data/models/supported_store.dart';
import 'package:savyor/data/models/user.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/network/error_handler/error_handler.dart';
import '../../../common/logger/log.dart';
import '../../domain/interfaces/i_app_repo_.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../remote_data_source/app_api/i_app_api.dart';
import '../remote_data_source/register_api/i_register_api.dart';

class AppRepo implements IAppRepo {
  AppRepo({required this.api});
  IAppApi api;




  @override
  Future<Either<Failure, SupportedStore>> getStores() async {
    try {
      final result = await api.getStores();
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

  @override
  Future<Either<Failure, ScrapInstructionResponse>> getScrappingInstruction(String store) async  {
    try {
      final result = await api.getScrappingInstruction(store);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

}