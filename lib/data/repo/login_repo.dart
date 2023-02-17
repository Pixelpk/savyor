import 'package:dartz/dartz.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/data/models/user.dart';
import 'package:savyor/domain/interfaces/i_login_repo_.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/network/error_handler/error_handler.dart';
import '../../../common/logger/log.dart';
import '../remote_data_source/login_api/i_login_api.dart';

class LoginRepo implements ILoginRepo {
  LoginRepo({required this.api});

  ILoginApi api;

  @override
  Future<Either<Failure, User>> login(Map<String, dynamic> map) async {
    try {
      final result = await api.login(map);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> forgotPassword(String email) async {
    try {
      final result = await api.forgotPassword(email);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }
}
