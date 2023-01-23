import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savyor/application/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params prams);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params prams);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

