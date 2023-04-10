import 'package:flutter/material.dart';

class Style {
  static const primaryColor = Color(0xff5C62AD);
  static const accentColor = Color(0xffAEB1D6);
  static const scaffoldBackground = Colors.white;
  static const scaffoldBackgroundDark = Color(0xff475063);
  static const disableColor = Color(0xffC7CAD0);
  static const textHintColor = Color(0xff51536B);
  static const hintColor = Color(0xff8B8D9D);
  static const textColor = Color(0xff171A3A);
  static const darkBorderColor = Color(0xff707070);
  static const black = Color(0xff000000);
  static const unSelectedColor = Color(0xffBABBC4);
  static const cardBg = Color(0xffF8F8F9);
  static const divider = Color(0xffC5C5CD);

  static BoxDecoration sectionBoxDecoration({double? radius, BorderRadius? borderRadius, Color? color}) =>
      BoxDecoration(color: color, borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10));
}
