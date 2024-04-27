








import '../../../libs.dart';

class AppRouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
        case AppRoutes.mainPage:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());
 case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case AppRoutes.notification:
        return MaterialPageRoute(builder: (_) => const NotificationAlarm());
      case AppRoutes.userProfile:
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());

      default:
      // If route not found, navigate to a default error page
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}