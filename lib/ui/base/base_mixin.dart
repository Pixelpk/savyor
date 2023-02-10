

import 'package:savyor/common/utils.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/di/di.dart';
import 'package:savyor/services/navService/i_navigation_service.dart';

mixin BaseMixin {
  final INavigationService _navigator = inject<INavigationService>();
  final Px _dimens = inject<Px>();
  final Utils _utils = inject<Utils>();
  INavigationService get navigator => _navigator;
  Px get dimens => _dimens;
  Utils get utils => _utils ;
}
