import 'package:agentapp/src/Views/splash_screen.dart';
import 'package:agentapp/src/routes/name_routes.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: NameRoutes.splashScreen,
      page: () => const SplashScreen(),
    ),
  ];
}
