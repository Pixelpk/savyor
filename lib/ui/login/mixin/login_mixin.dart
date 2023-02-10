import 'package:flutter/material.dart';
import 'package:savyor/common/utils.dart';
import 'package:savyor/services/media_service/i_media_service.dart';

import '../../../di/di.dart';
import '../../base/base_widget.dart';

mixin LoginMixin<T extends BaseStateFullWidget> on State<T> {
  late final TextEditingController name;
  late final TextEditingController password;
  late GlobalKey<FormState> validKey;
  late bool obscureText ;
  late bool confirmObscureText ;
  late final Utils utils ;




  @override
  void initState() {
    name = TextEditingController();
    password = TextEditingController();
    validKey = GlobalKey<FormState>();
    obscureText = true;
    confirmObscureText = true;
    utils = inject();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    password.dispose();
    super.dispose();
  }

  bool get validated => validKey.currentState?.validate() ?? false;
}
