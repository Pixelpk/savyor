import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

@immutable abstract class IMediaService{
  Future<XFile?> pickImage();
  Future<XFile?> captureImage();
}