import 'package:dartz/dartz.dart';
import 'package:savyor/domain/interfaces/i_user_repo_.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/UserProfileImage.dart';

class GetUserProfileUseCase implements UseCase<GetUserProfile, NoParams> {
  GetUserProfileUseCase(this.repository);
  final IUserRepo repository;

  @override
  Future<Either<Failure, GetUserProfile>> call(NoParams params) async {
    return repository.getUserProfile();
  }
}
