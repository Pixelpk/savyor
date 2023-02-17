import 'package:dartz/dartz.dart';
import 'package:savyor/domain/interfaces/i_user_repo_.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/track_product.dart';
import '../entities/password_entity/password_entity.dart';

class ChangePasswordUseCase implements UseCase<ServerResponse, PasswordEntity> {
  ChangePasswordUseCase(this.repository);

  final IUserRepo repository;

  @override
  Future<Either<Failure, ServerResponse>> call(PasswordEntity params) async {
    return repository.changePassword(params.toJson());
  }
}
