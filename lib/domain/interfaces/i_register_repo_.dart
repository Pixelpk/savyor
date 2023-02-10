
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../application/core/failure/failure.dart';
import '../../data/models/user.dart';

abstract class IRegisterRepo {
  Future<Either<Failure, User>> register(FormData map);
}
