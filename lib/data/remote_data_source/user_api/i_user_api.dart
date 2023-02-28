import 'package:dio/dio.dart';
import 'package:savyor/data/models/user.dart';

import '../../models/UserProfileImage.dart';
import '../../models/supported_store.dart';
import '../../models/track_product.dart';

abstract class IUserApi {
  Future<GetUserProfile> getUserProfile();

  Future<ServerResponse> updateProfileImage(FormData formData);

  Future<ServerResponse> changePassword(Map<String, dynamic> data);
}