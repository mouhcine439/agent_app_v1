import 'package:agentapp/src/models/alert_model.dart';
import 'package:get/get.dart';

class AlertsController extends GetxController {
  final RxList<AlertModel> alerts =
      <AlertModel>[].obs;

  void initialize() {
    alerts.assignAll(mockAlerts);
  }

  int get unreadCount {
    return alerts
        .where((alert) => !alert.isRead)
        .length;
  }
}