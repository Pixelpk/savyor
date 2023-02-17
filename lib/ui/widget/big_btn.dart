import 'package:flutter/material.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/ui/base/base_widget.dart';

class BigBtn extends BaseStateLessWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool showGradient;
  final Color color;
  final double? radius;
  final double? height;
  final double? width;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final Color borderColor;
  final bool showArrow;

  BigBtn(
      {required this.onTap,
      Key? key,
      this.showArrow = false,
      required this.child,
      this.padding = EdgeInsets.zero,
      this.borderColor = Colors.transparent,
      this.showGradient = false,
      this.radius,
      this.color = Style.scaffoldBackground,
      this.elevation = 4.0,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: TextButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? dimens.defaultRadius)),
                backgroundColor: color,
                maximumSize: Size(width ?? context.width, height ?? dimens.k50),
                padding: EdgeInsets.zero,
                elevation: elevation),
            child: Container(
                height: height ?? dimens.k50,
                decoration: Style.sectionBoxDecoration(radius: radius ?? dimens.defaultRadius)
                    .copyWith(border: Border.all(color: borderColor)),
                child: Center(child: child))));
  }
}
