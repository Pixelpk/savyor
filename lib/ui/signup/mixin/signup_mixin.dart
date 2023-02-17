import 'package:flutter/material.dart';
import 'package:savyor/common/utils.dart';
import 'package:savyor/services/media_service/i_media_service.dart';

import '../../../di/di.dart';
import '../../base/base_widget.dart';

mixin RegisterMixin<T extends BaseStateFullWidget> on State<T> {
  late final TextEditingController name;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;
  late GlobalKey<FormState> validKey;
  late bool obscureText = true;
  late bool obscureText2 = true;
  late final IMediaService iMediaService;

  late final Utils utils;

  @override
  void initState() {
    name = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    validKey = GlobalKey<FormState>();
    obscureText = true;
    obscureText2 = true;
    iMediaService = inject();
    utils = inject();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  bool get validated => validKey.currentState?.validate() ?? false;
}
