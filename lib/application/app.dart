import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savyor/application/core/extensions/extensions.dart';
import 'package:savyor/application/core/scroll_behavior.dart';
import 'package:savyor/application/main_config/routes/route_path.dart';
import 'package:savyor/constant/style.dart';
import 'package:savyor/services/my_reflectable.dart';
import 'package:savyor/ui/account/user_view_model.dart';
import 'package:savyor/ui/base/base_mixin.dart';
import 'package:savyor/ui/home/home_view_model.dart';

import '../common/logger/log.dart';
import '../main.dart';

class SavyorApp extends StatefulWidget {
  final SetRegisteredRoutes? route;

  const SavyorApp({Key? key, this.route}) : super(key: key);

  @override
  State<SavyorApp> createState() => SavyorAppState();
}

class SavyorAppState extends State<SavyorApp> with BaseMixin {
  @override
  void initState() {
    super.initState();
    final script = ScriptGenerator(
        diyIdScript: "return document.querySelector(\"input#ASIN, input[name='asin']\").value;",
        name: "Laoshe",
        websiteUrl: "www.amazon.com");
    d(script.generateCode());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => AccountViewModel())
      ],
      child: MaterialApp(
        title: 'Savyor',
        builder: (context, child) => ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: child!,
        ),

        initialRoute: RoutePath.initialRoute,
        onGenerateRoute: widget.route,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigator.key(),
        color: Style.primaryColor,
        theme: ThemeData(
            fontFamily: 'DM Sans',
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            selectedRowColor: Colors.transparent,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              iconTheme: const IconThemeData(color: Style.textColor),
              toolbarTextStyle: context.textTheme.bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold, color: Style.textColor, fontSize: 18),
              titleTextStyle: context.textTheme.bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold, color: Style.textColor, fontSize: 18),
            ),
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light(
                background: Style.scaffoldBackground,
                secondary: Style.accentColor,
                primary: Style.primaryColor,
                brightness: Brightness.light)),
        // darkTheme: ThemeData(
        //     highlightColor: Colors.transparent,
        //     splashColor: Colors.transparent,
        //     backgroundColor: Colors.white,
        //     selectedRowColor: Colors.transparent,
        //     colorScheme: const ColorScheme.dark(
        //         background: Style.scaffoldBackgroundDark, secondary: Style.accentColor, primary: Style.primaryColor, brightness: Brightness.dark)),
      ),
    );
  }
}
