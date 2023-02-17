import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:savyor/domain/interfaces/i_user_repo_.dart';

import '../../../application/core/failure/failure.dart';
import '../../../application/core/usecases/usecase.dart';
import '../../data/models/track_product.dart';

class UpdateProfileImageUseCase implements UseCase<ServerResponse, FormData> {
  UpdateProfileImageUseCase(this.repository);

  final IUserRepo repository;

  @override
  Future<Either<Failure, ServerResponse>> call(FormData params) async {
    return repository.updateProfileImage(params);
  }
}
