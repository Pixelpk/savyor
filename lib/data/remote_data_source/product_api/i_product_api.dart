import '../../models/active_product.dart';
import '../../models/track_product.dart';

abstract class IProductApi {
  Future<ActiveProduct> getActiveProducts();

  Future<ActiveProduct> getInActiveProducts();

  Future<ServerResponse> trackProduct(Map<String, dynamic> data);

  Future<ServerResponse> updateProduct(Map<String, dynamic> data);
}
