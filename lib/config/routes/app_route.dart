import '../../features/auth/presentation/view/dashboard_view.dart';
import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
import '../../features/splash/presentation/view/splash_screen_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashScreenRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String registerRoute = '/registerRoute';
  static const String dashboardRoute = '/dashboardRoute';

  static getAppRoutes() {
    return {
      splashScreenRoute: (context) => const SplashScreenView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      dashboardRoute: (context) => const DashboardPage(),
    };
  }
}
