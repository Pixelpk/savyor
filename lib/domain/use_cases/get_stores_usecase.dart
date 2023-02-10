import 'package:dartz/dartz.dart';
import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/supported_store.dart';
import '../../data/models/user.dart';
import '../entities/signup_entity/sign_up_entity.dart';
import '../interfaces/i_app_repo_.dart';
import '../interfaces/i_register_repo_.dart';

class GetStoreUseCase implements UseCase<SupportedStore, NoParams> {
  GetStoreUseCase(this.repository);
  final IAppRepo repository;

  @override
  Future<Either<Failure, SupportedStore>> call(NoParams params) async {
    return repository.getStores();
  }
}
