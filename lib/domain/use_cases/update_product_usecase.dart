import 'package:dartz/dartz.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/track_product.dart';
import '../entities/update_product_entity/track_product_entity.dart';

class UpdateProductUseCase implements UseCase<ServerResponse, UpdateProductEntity> {
  UpdateProductUseCase(this.repository);

  final IProductRepo repository;

  @override
  Future<Either<Failure, ServerResponse>> call(UpdateProductEntity params) async {
    return repository.updateProduct(params.toJson());
  }
}
