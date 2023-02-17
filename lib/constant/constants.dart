import 'package:flutter/material.dart';
import 'package:savyor/constant/style.dart';

extension SizeExt on double {
  SizedBox verticalBoxPadding() => SizedBox(height: this);
  SizedBox horizontalBoxPadding() => SizedBox(width: this);
}

class Px {
  final double kDefaultDuration = .25;
  static const toolBar = 80.0;
  final defaultRadius = 20.0;
  double get statusBarSize => 30;
  double get extendSizeBodyBehindAppBar => toolBar + statusBarSize;
  final kDefault = 0.0;
  final k2 = 2.0;
  final k3 = 3.0;
  final k4 = 4.0;
  final k5 = 5.0;
  final k6 = 6.0;
  final k7 = 7.0;
  final k8 = 8.0;
  final k10 = 10.0;
  final k12 = 12.0;
  final k14 = 14.0;
  final k15 = 15.0;
  final k16 = 16.0;
  final k18 = 18.0;
  final k20 = 20.0;
  final k22 = 22.0;
  final k25 = 25.0;
  final k28 = 28.0;
  final k30 = 30.0;
  final k36 = 36.0;
  final k40 = 40.0;
  final k45 = 45.0;
  final k47 = 47.0;
  final k50 = 50.0;
  final k55 = 55.0;
  final k56 = 56.0;
  final k60 = 60.0;
  final k70 = 70.0;
  final k80 = 80.0;
  final k85 = 85.0;
  final k90 = 90.0;
  final k100 = 100.0;
  final k200 = 200.0;
  final k110 = 110.0;
  final k130 = 130.0;
  final k140 = 140.0;
  final k150 = 150.0;
  final k160 = 160.0;
  final k170 = 170.0;
  final k180 = 180.0;
  final k250 = 250.0;
  final k300 = 300.0;
  final k350 = 350.0;
  final k400 = 400.0;
  double get toolBarHeight => toolBar;
}
