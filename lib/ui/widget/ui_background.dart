import 'dart:io';

import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/Images/svgs.dart';
import 'package:savyor/ui/base/base_widget.dart';

class UiBackground extends BaseStateLessWidget {
   UiBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Stack(
      fit: StackFit.expand,
      children: [
        Positioned(top: 0, left: 0, child: Assets.union),
        bottomCurve(context)
      ],
    );
  }

 Widget bottomCurve(BuildContext context){
    switch(context.getDeviceType) {
      case DeviceType.phone:
       return Positioned(bottom: -15, right: -15, left: -15, child: Assets.unionBottom3);
      case DeviceType.tablet:
       return Positioned(bottom: -15, right: -15, child: Assets.unionBottom3);
    }

  }
}
