import 'package:dartz/dartz.dart';
import 'package:savyor/data/models/active_product.dart';

import '../../../../application/core/failure/failure.dart';
import '../../data/models/track_product.dart';

abstract class IProductRepo {
  Future<Either<Failure, ActiveProduct>> getActiveProducts();

  Future<Either<Failure, ActiveProduct>> getInActiveProducts();

  Future<Either<Failure, ServerResponse>> trackProduct(Map<String, dynamic> data);

  Future<Either<Failure, ServerResponse>> updateProduct(Map<String, dynamic> data);
}
