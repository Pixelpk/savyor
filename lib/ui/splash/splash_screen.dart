import 'package:flutter/material.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/ui/base/base_widget.dart';
import 'package:savyor/ui/widget/ui_background.dart';

class SplashScreen extends BaseStateFullWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}


class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), (){
      widget.navigator.pushNamedAndRemoveUntil(RoutePath.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          UiBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Assets.logo2x,
            ),
          ),
        ],
      ),
    ));
  }
}
