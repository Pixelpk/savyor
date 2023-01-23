
import 'package:savyor/application/core/failure/failure.dart';

abstract class Result<T> {
  onSuccess(T result);
  onError(Failure error);
}

abstract class ShowError {

  onError(Failure error);
}