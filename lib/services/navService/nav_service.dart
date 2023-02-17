import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:savyor/services/navService/i_navigation_service.dart';

class NavigationService implements INavigationService {
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  @override
  Future<dynamic>? pushNamed(String path, {Object? object}) {
    return _key.currentState?.pushNamed(path, arguments: object);
  }

  @override
  Future<dynamic>? pushNamedAndRemoveUntil(String path, {Object? object}) {
    return _key.currentState?.pushNamedAndRemoveUntil(path, (route) => false, arguments: object);
  }

  @override
  Future<dynamic>? pushReplacementNamed(String path, {Object? object}) {
    return _key.currentState?.pushReplacementNamed(path, arguments: object);
  }

  @override
  GlobalKey<NavigatorState> key() => _key;

  @override
  void pop([Object? result]) {
    return _key.currentState?.pop(result);
  }

  @override
  Future<bool?> showNAVDialog(String title, String content, {bool dismissOnly = false}) async {
    return await showDialog<bool>(
      context: _key.currentContext!,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: dismissOnly
              ? <Widget>[
                  TextButton(
                    child: const Text('Dismiss'),
                    onPressed: () {
                      _key.currentState?.pop(true); // Dismiss alert dialog
                    },
                  ),
                ]
              : <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      _key.currentState?.pop(false); // Dismiss alert dialog
                    },
                  ),
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      _key.currentState?.pop(true); // Dismiss alert dialog
                    },
                  ),
                ],
        );
      },
    );
  }

  @override
  Future<void> showLoadingDialog() async {
    return await showDialog<void>(
      context: _key.currentContext!,
      builder: (BuildContext dialogContext) {
        return const AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Future<void> showCustomDialog(Widget content) {
    return showGeneralDialog(
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim1, anim2) => content,
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
      context: _key.currentContext!,
    );
  }
}
