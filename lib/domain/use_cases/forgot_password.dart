import 'package:dartz/dartz.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/domain/interfaces/i_login_repo_.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';

class ForgotPasswordUseCase implements UseCase<ServerResponse, String> {
  ForgotPasswordUseCase(this.repository);

  final ILoginRepo repository;

  @override
  Future<Either<Failure, ServerResponse>> call(String params) async {
    return repository.forgotPassword(params);
  }
}
