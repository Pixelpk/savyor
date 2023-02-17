import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../application/core/failure/failure.dart';
import '../../data/models/UserProfileImage.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/track_product.dart';
import '../../data/models/user.dart';

abstract class IUserRepo {
  Future<Either<Failure, GetUserProfile>> getUserProfile();

  Future<Either<Failure, ServerResponse>> updateProfileImage(FormData formData);

  Future<Either<Failure, ServerResponse>> changePassword(Map<String, dynamic> data);
}
