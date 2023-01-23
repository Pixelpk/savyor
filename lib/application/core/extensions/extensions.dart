import 'package:flutter/material.dart';
enum DeviceType { phone, tablet }

extension ExtensionNum on num {
  String get twoDigits => toString().padLeft(2, "0");
}




extension ExtensionDuration on Duration {
  String get humanize =>
      "${inDays > 0 ? '${inDays}d ' : ''}${inHours.remainder(24).twoDigits}h:${inMinutes.remainder(60).twoDigits}m:${inSeconds.remainder(60).twoDigits}s";
}

extension StringExtension on String {
  int toInt() => int.parse(this);

  double toFloat() => double.parse(this);

  String defaultOnEmpty([String defaultValue = ""]) => isEmpty ? defaultValue : this;
}

extension ContextExtension on BuildContext {
  double getHeight([double factor = 1]) {
    // assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    // assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();

  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool hasPixel() {
    final double pixelPk = MediaQuery.of(this).devicePixelRatio;
    return pixelPk > 2.0;
  }

  double pixel() {
    final double pixelPk = MediaQuery.of(this).devicePixelRatio;
    return pixelPk;
  }

  DeviceType get getDeviceType => MediaQuery.of(this).size.shortestSide < 550 ? DeviceType.phone : DeviceType.tablet;

}

extension ClickableExtension on Widget {
  Widget onTap(VoidCallback? action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}

extension AddPadding on Widget {
  Widget addPadding(EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: this,
    );
  }
}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  DateTime firstDateOfTheWeek() {
    return subtract(Duration(days: weekday - 1));
  }

  DateTime lastDateOfTheWeek() {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  DateTime lastDayOfMonth() =>
      ((month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1)).subtract(const Duration(days: 1));
}
