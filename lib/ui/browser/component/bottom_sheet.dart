import 'package:flutter/material.dart';
import 'package:savyor/constant/style.dart';

class Popover extends StatelessWidget {
  const Popover({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: theme.cardColor, borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: child);
  }

  Widget _buildHandle(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.25,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
                height: 5.0,
                decoration: const BoxDecoration(
                    color: Style.unSelectedColor, borderRadius: BorderRadius.all(Radius.circular(2.5))))));
  }
}
