import 'package:dartz/dartz.dart';
import 'package:savyor/data/models/active_product.dart';
import 'package:savyor/domain/interfaces/i_product_repo.dart';
import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/user.dart';
import '../entities/signup_entity/sign_up_entity.dart';
import '../interfaces/i_app_repo_.dart';
import '../interfaces/i_register_repo_.dart';

class GetActiveProductUseCase implements UseCase<ActiveProduct, NoParams> {
  GetActiveProductUseCase(this.repository);
  final IProductRepo repository;

  @override
  Future<Either<Failure, ActiveProduct>> call(NoParams params) async {
    return repository.getActiveProducts();
  }
}
