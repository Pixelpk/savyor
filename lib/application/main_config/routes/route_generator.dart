part of 'route_import.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutePath.initialRoute:
        return PageRouter.fadeScale(() => SplashScreen());
      case RoutePath.login:
        return PageRouter.fadeScale(
            () => ChangeNotifierProvider(create: (_) => LoginViewModel(), child: LoginScreen()));
      case RoutePath.forgotPassword:
        return PageRouter.fadeScale(() => ChangeNotifierProvider(create: (_) => LoginViewModel(),child: ForgotPasswordScreen()));
      case RoutePath.pinCode:
        return PageRouter.fadeScale(() => PinCodeScreen(
              email: args as String,
            ));
      case RoutePath.signup:
        return PageRouter.fadeScale(
            () => ChangeNotifierProvider(create: (_) => RegisterViewModel(), child: SignupScreen()));
      case RoutePath.welcome:
        return PageRouter.fadeScale(() => WelcomeScreen());      case RoutePath.password:
        return PageRouter.fadeScale(() => Password());

      case RoutePath.home:
        return PageRouter.fadeScale(() => Home());  case RoutePath.aboutPage:
        return PageRouter.fadeScale(() => AboutPage()); case RoutePath.privacy:
        return PageRouter.fadeScale(() => Privacy());
      case RoutePath.detail:
        return PageRouter.fadeScale(() => MyListDetail(
              product: args as Product,
            ));
      case RoutePath.webView:
        return PageRouter.fadeScale(() => CustomInAppWebView(
              url: args as String,
            ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Container(
            color: Style.scaffoldBackground,
            child: const Text('Page Not Found'),
          ),
        ),
      );
    });
  }
}
