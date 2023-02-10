
import 'package:dio/dio.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/data/models/user.dart';


abstract class ILoginApi {
  Future<User> login(Map<String,dynamic> data);
  Future<ServerResponse> forgotPassword(String email);
}
