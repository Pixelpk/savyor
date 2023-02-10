
import 'package:dio/dio.dart';
import 'package:savyor/data/models/user.dart';

import '../../models/active_product.dart';
import '../../models/supported_store.dart';
import '../../models/track_product.dart';


abstract class IProductApi {
  Future<ActiveProduct> getActiveProducts();
  Future<ServerResponse> trackProduct(Map<String, dynamic> data);
  Future<ServerResponse> updateProduct(Map<String, dynamic> data);
}
