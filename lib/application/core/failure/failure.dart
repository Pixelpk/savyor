
abstract class Failure {}

class ConnectTimeoutFailure implements Failure {}

class ReceiveTimeoutFailure implements Failure {}

class SendTimeoutFailure implements Failure {}

class ResponseFailure implements Failure {
  ResponseFailure({required this.msg, this.code});

  String msg;
  dynamic code;
}

class OtherFailure implements Failure {}

class DefaultFailure implements Failure {}
