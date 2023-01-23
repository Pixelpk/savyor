import 'package:flutter/foundation.dart';
import 'package:savyor/ui/base/base_mixin.dart';

class BaseViewModel extends ChangeNotifier with BaseMixin {

  @protected
  void setState() => notifyListeners();
}