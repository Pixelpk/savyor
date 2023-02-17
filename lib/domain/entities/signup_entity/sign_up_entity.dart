import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class SignUpEntity {
  String? userName;
  String? password;
  XFile? image;

  SignUpEntity({this.userName, this.password, this.image});

  Future<FormData> toJson() async {
    if (image != null) {
      return FormData.fromMap({
        "image": await MultipartFile.fromFile(image!.path, filename: image!.path.split('/').last),
        "username": userName,
        "password": password
      });
    } else {
      return FormData.fromMap({"username": userName, "password": password});
    }
  }
}
