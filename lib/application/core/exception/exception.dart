
class ConnectTimeoutException implements Exception {}

class ReceiveTimeoutException implements Exception {}

class SendTimeoutException implements Exception {}

class ResponseException implements Exception {
  ResponseException({required this.msg,this.code});

  String msg;
  dynamic code ;
}

class OtherException implements Exception {}

class DefaultException implements Exception {}
