
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:savyor/application/core/usecases/usecase.dart';
import 'package:savyor/data/models/track_product.dart';

import '../../../../application/core/failure/failure.dart';
import '../../data/models/user.dart';

abstract class ILoginRepo {
  Future<Either<Failure, User>> login(Map<String,dynamic> map);
  Future<Either<Failure, ServerResponse>> forgotPassword(String email);
}
