import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxBool notificationsEnabled = true.obs;
  final RxBool offlineModeEnabled = false.obs;

  final String name = 'Agent utilisateur';
  final String email = 'agent@example.com';
  final String role = 'Agent de contrôle';

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void toggleOfflineMode(bool value) {
    offlineModeEnabled.value = value;
  }
}