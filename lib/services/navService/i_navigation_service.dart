import 'package:flutter/material.dart';

abstract class INavigationService {
  GlobalKey<NavigatorState> key();
  Future<dynamic>? pushNamedAndRemoveUntil(String path, {Object? object});
  Future<dynamic>? pushNamed(String path, {Object? object});
  Future<dynamic>? pushReplacementNamed(String path, {Object? object});
  void pop([ Object? result ]);
  Future<bool?> showNAVDialog(String title, String content, {bool dismissOnly});
  Future<void> showLoadingDialog();
  Future<void> showCustomDialog(Widget content);
}