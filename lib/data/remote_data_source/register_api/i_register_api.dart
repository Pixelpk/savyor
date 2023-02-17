import 'package:dio/dio.dart';
import 'package:savyor/data/models/user.dart';

abstract class IRegisterApi {
  Future<User> register(FormData data);
}
