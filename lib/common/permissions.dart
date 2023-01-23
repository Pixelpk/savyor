

import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionManager{
  Future<bool> checkStoragePermission();
}

class PermissionManager implements IPermissionManager {
  @override
  Future<bool> checkStoragePermission() async {
    var storage = await Permission.storage.status;
    if (storage.isGranted) {
     return true;
    } else {
      final requested = await [Permission.storage].request();
      if (requested[Permission.storage]!.isGranted) {
        return true;
      }else{
        return false;
      }
    }
  }

}
