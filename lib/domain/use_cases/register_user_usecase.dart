import 'package:dartz/dartz.dart';
import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/user.dart';
import '../entities/signup_entity/sign_up_entity.dart';
import '../interfaces/i_register_repo_.dart';

class RegisterUserUseCase implements UseCase<User, SignUpEntity> {
  RegisterUserUseCase(this.repository);
  final IRegisterRepo repository;

  @override
  Future<Either<Failure, User>> call(SignUpEntity params) async {
    return repository.register(await params.toJson());
  }
}
