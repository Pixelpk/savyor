import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/routes/routes.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/data/models/active_product.dart';
import 'package:savyor/ui/browser/web_view.dart';
import 'package:savyor/ui/home/home.dart';
import 'package:savyor/ui/login/forgot_password_screen.dart';
import 'package:savyor/ui/login/login_screen.dart';
import 'package:savyor/ui/login/pin_code_screen.dart';
import 'package:savyor/ui/my_list/my_list_detail.dart';
import 'package:savyor/ui/signup/signup_screen.dart';
import 'package:savyor/ui/signup/welcome_screen.dart';
import 'package:savyor/ui/splash/splash_screen.dart';

import '../../../ui/about/about.dart';
import '../../../ui/login/login_view_model.dart';
import '../../../ui/privacy/privacy.dart';
import '../../../ui/signup/register_view_model.dart';
import '../../../ui/update_password/password.dart';

part 'route_generator.dart';