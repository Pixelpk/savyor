import 'package:dartz/dartz.dart';
import 'package:savyor/data/models/active_product.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/data/remote_data_source/product_api/i_product_api.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/network/error_handler/error_handler.dart';
import '../../../common/logger/log.dart';

class ProductRepo implements IProductRepo {
  ProductRepo({required this.api});

  IProductApi api;

  @override
  Future<Either<Failure, ActiveProduct>> getActiveProducts() async {
    try {
      final result = await api.getActiveProducts();
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

  @override
  Future<Either<Failure, ActiveProduct>> getInActiveProducts() async {
    try {
      final result = await api.getInActiveProducts();
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> trackProduct(Map<String, dynamic> data) async {
    try {
      final result = await api.trackProduct(data);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }

  @override
  Future<Either<Failure, ServerResponse>> updateProduct(Map<String, dynamic> data) async {
    try {
      final result = await api.updateProduct(data);
      return Right(result);
    } catch (error) {
      d(error);
      return Left(getFailure(error as Exception));
    }
  }
}
