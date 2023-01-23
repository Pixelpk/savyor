import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function();

class PageRouter {
  static const double kDefaultDuration = .25;

  static Route<T> fadeThrough<T>(PageBuilder pageBuilder,
      [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }

  static Route<T> fadeScale<T>(PageBuilder pageBuilder,
      [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(
          animation: animation,
          child: child,
        );
      },
    );
  }

  static Route<T> clipperRoute<T>(PageBuilder pageBuilder,
      [double duration = kDefaultDuration]) {
    return PageRouteBuilder<T>(
      barrierDismissible: false,
      maintainState: true,
      barrierColor: Colors.transparent,
      barrierLabel: null,
      opaque: false,
      transitionDuration: Duration(milliseconds: (duration * 1000).round()),
      pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ClipPath(
          clipper: MyClipper(animation.value),
          child: child,
        );
      },
    );
  }
}
class MyClipper extends CustomClipper<Path> {
  final double value;

  MyClipper(this.value);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(
      Rect.fromCircle(center: Offset(size.width/2, (size.height / 2) - 150.0), radius: value *size.height),
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}