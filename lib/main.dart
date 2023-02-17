import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:savyor/application/main_config/main_config.dart' as config;
import 'package:savyor/application/app.dart';
import 'package:savyor/application/main_config/routes/route_import.dart';
import 'package:savyor/common/logger/log.dart';
import 'main.reflectable.dart';

typedef SetRegisteredRoutes = Route<dynamic> Function(RouteSettings settings);

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    d("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    d("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    d("ChromeSafari browser closed");
  }
}

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    await config.initMainServiceLocator();
    const routes = RouteGenerator.generateRoute;
    const root = SavyorApp(route: routes);
    initializeReflectable();
    runApp(root);
  }, (error, stackTrace) async {
    d('ZonedGuardedError:  ${error.toString()} $stackTrace');
  });
}
