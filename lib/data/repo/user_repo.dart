import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:savyor/data/models/UserProfileImage.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/data/models/user.dart';
import 'package:savyor/data/remote_data_source/user_api/i_user_api.dart';
import 'package:savyor/domain/interfaces/i_user_repo_.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/network/error_handler/error_handler.dart';
import '../../../common/logger/log.dart';
import '../../domain/interfaces/i_register_repo_.dart';
import '../remote_data_source/register_api/i_register_api.dart';

class UserRepo implements IUserRepo {
  UserRepo({required this.api});
  IUserApi api;

  @override
  Future<Either<Failure, ServerResponse>> changePassword(Map<String, dynamic> data) async {
    try {
      final result = await api.changePassword(data);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

  @override
  Future<Either<Failure, GetUserProfile>> getUserProfile() async {
    try {
      final result = await api.getUserProfile();
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> updateProfileImage(FormData formData) async {
    try {
      final result = await api.updateProfileImage(formData);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }
}
