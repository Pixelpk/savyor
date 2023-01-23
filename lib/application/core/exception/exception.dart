
class ConnectTimeoutException implements Exception {}

class ReceiveTimeoutException implements Exception {}

class SendTimeoutException implements Exception {}

class ResponseException implements Exception {
  ResponseException({required this.msg});

  String msg;
}

class OtherException implements Exception {}

class DefaultException implements Exception {}
