import 'package:image_picker/image_picker.dart';

import '../../common/logger/log.dart';
import 'i_media_service.dart';

class MediaService implements IMediaService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> captureImage() async {
    try {
      return await _picker.pickImage(source: ImageSource.camera);
    } catch (e) {
      d(e);
      return null;
    }
  }

  @override
  Future<XFile?> pickImage() async {
    try {
      return await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      d(e);
      return null;
    }
  }
}
