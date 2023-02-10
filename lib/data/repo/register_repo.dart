import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:savyor/data/models/user.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/network/error_handler/error_handler.dart';
import '../../../common/logger/log.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../remote_data_source/register_api/i_register_api.dart';

class RegisterRepo implements IRegisterRepo {
  RegisterRepo({required this.api});
  IRegisterApi api;


  @override
  Future<Either<Failure, User>> register(FormData map) async {
    try {
      final result = await api.register(map);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

}