import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/data/local_data_source/preference/i_pref_helper.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/home/home_view_model.dart';
import 'package:savyor/ui/widget/ui_background.dart';

import '../../common/logger/log.dart';
import '../../data/models/user.dart';
import '../../di/di.dart';

loadAppData(BuildContext context) async {
  await Future.wait([context.read<HomeViewModel>().getSupportedStores()]);
}

class SplashScreen extends BaseStateFullWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  validateSession() async {
    Timer(const Duration(seconds: 3), () async {
      final prefHelper = inject<IPrefHelper>();

      if (prefHelper.getBool('isFirstTime') ?? true) {
        prefHelper.saveBool('isFirstTime', false);
        widget.navigator.pushNamedAndRemoveUntil(RoutePath.welcome);
      } else {
        final token = prefHelper.retrieveToken();
        final user = prefHelper.retrieveUser();
        d(user.runtimeType);
        if (token != null && user.runtimeType == User) {
          await loadAppData(context);
          widget.navigator.pushNamedAndRemoveUntil(RoutePath.home);
        } else {
          widget.navigator.pushNamedAndRemoveUntil(RoutePath.login);
        }
      }
    });
  }

  @override
  void initState() {
    Future.microtask(() => validateSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      UiBackground(),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 25), child: Center(child: Assets.logo2x))
    ])));
  }
}
