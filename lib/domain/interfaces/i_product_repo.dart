
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:savyor/data/models/active_product.dart';

import '../../../../application/core/failure/failure.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/track_product.dart';
import '../../data/models/user.dart';

abstract class IProductRepo {
  Future<Either<Failure, ActiveProduct>> getActiveProducts();
  Future<Either<Failure, ServerResponse>> trackProduct(Map<String,dynamic> data);
  Future<Either<Failure, ServerResponse>> updateProduct(Map<String,dynamic> data);
}
