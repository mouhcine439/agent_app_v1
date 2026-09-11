import 'package:agentapp/src/Views/alerts/alerts_screen.dart';
import 'package:agentapp/src/Views/auth/login_screen.dart';
import 'package:agentapp/src/Views/home/home_screen.dart';
import 'package:agentapp/src/Views/profile/profile_screen.dart';
import 'package:agentapp/src/Views/questionnaire/questionnaire_screen.dart';
import 'package:agentapp/src/Views/scan/scan_screen.dart';
import 'package:agentapp/src/Views/splash_screen.dart';
import 'package:agentapp/src/Views/tour/tour_detail_screen.dart';
import 'package:agentapp/src/routes/name_routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: NameRoutes.splashScreen,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: NameRoutes.loginScreen,
      page: () => const LoginScreen(),
    ),

    GetPage(
      name: NameRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),

    GetPage(
      name: NameRoutes.tourDetailScreen,
      page: () => const TourDetailScreen(),
    ),

    GetPage(
      name: NameRoutes.scanScreen,
      page: () => const ScanScreen(),
    ),

    GetPage(
      name: NameRoutes.questionnaireScreen,
      page: () => const QuestionnaireScreen(),
    ),

    GetPage(
      name: NameRoutes.alertsScreen,
      page: () => const AlertsScreen(),
    ),

    GetPage(
      name: NameRoutes.profileScreen,
      page: () => const ProfileScreen(),
    ),
  ];
}