import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savyor/constant/constants.dart';
import 'package:savyor/ui/base/base_widget.dart';

class SectionVerticalWidget extends BaseStateLessWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final Widget? thirdWidget;
  final double? gap;
  final CrossAxisAlignment? crossAxisAlignment;

  SectionVerticalWidget(
      {Key? key,
      this.gap,
      required this.firstWidget,
      required this.secondWidget,
      this.thirdWidget,
      this.crossAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double _gap = gap ?? (_scale <= 1 ? 8 : lerpDouble(8, 4, math.min(_scale - 1, 1)))!;
    List<Widget> child = thirdWidget != null
        ? [firstWidget, _gap.verticalBoxPadding(), secondWidget, _gap.verticalBoxPadding(), thirdWidget!]
        : [firstWidget, _gap.verticalBoxPadding(), secondWidget];

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: child);
  }
}
