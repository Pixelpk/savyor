import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class LoginEntity {
  String? userName;
  String? password;

  LoginEntity({this.userName, this.password});

  Map<String,dynamic> toJson()  {
    Map<String,dynamic> data = {};
    data["username"] = userName;
    data["password"] = password;
    return data ;
  }
}
