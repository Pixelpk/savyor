import 'package:dartz/dartz.dart';
import 'package:savyor/domain/interfaces/i_login_repo_.dart';
import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/user.dart';
import '../entities/login_entity/login_enityt.dart';
import '../entities/signup_entity/sign_up_entity.dart';
import '../interfaces/i_register_repo_.dart';

class LoginUserUseCase implements UseCase<User, LoginEntity> {
  LoginUserUseCase(this.repository);

  final ILoginRepo repository;

  @override
  Future<Either<Failure, User>> call(LoginEntity params) async {
    return repository.login(params.toJson());
  }
}
