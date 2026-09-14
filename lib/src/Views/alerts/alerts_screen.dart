import 'package:agentapp/src/Controllers/alerts_controller.dart';
import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/alert_model.dart';
import 'package:agentapp/src/widgets/app_bottom_nav_bar.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agentapp/src/routes/name_routes.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({
    super.key,
  });

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  late final AlertsController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      AlertsController(),
    );

    controller.initialize();
  }

  @override
  void dispose() {
    Get.delete<AlertsController>();
    super.dispose();
  }

  Color _getIconColor(AlertType type) {
    switch (type) {
      case AlertType.warning:
        return AppColors.goldColor;

      case AlertType.error:
        return AppColors.errorColor;

      case AlertType.info:
        return AppColors.blueColor;

      case AlertType.success:
        return AppColors.valideColor;
    }
  }

  IconData _getIcon(AlertType type) {
    switch (type) {
      case AlertType.warning:
        return Icons.warning_amber_rounded;

      case AlertType.error:
        return Icons.error_outline_rounded;

      case AlertType.info:
        return Icons.info_outline_rounded;

      case AlertType.success:
        return Icons.check_circle_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      scafoldBody: Scaffold(
        backgroundColor: AppColors.bgColor,

        // =========================
        // APP BAR
        // =========================
        appBar: CustomAppbar(
          title: 'Alertes',
          showBtn: false,
          showBtnSearch: false,
          centerTitle: false,
        ),

        // =========================
        // BODY
        // =========================
        body: Obx(
          () {
            if (controller.alerts.isEmpty) {
              return const Center(
                child: Text(
                  'Aucune alerte',
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.alerts.length,
              itemBuilder: (
                context,
                index,
              ) {
                final alert = controller.alerts[index];

                final iconColor =
                    _getIconColor(alert.type);

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.greyColor.withOpacity(0.25),
                    ),
                  ),

                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      // =========================
                      // ICON
                      // =========================
                      Container(
                        width: 44,
                        height: 44,

                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          _getIcon(alert.type),
                          color: iconColor,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // =========================
                      // ALERT CONTENT
                      // =========================
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            CustomText(
                              title: alert.title,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackColor,
                            ),

                            const SizedBox(height: 5),

                            CustomText(
                              title: alert.message,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: AppColors.greyColor,
                            ),

                            const SizedBox(height: 8),

                            CustomText(
                              title: alert.date,
                              fontSize: 11,
                              fontWeight: FontWeight.normal,
                              color: AppColors.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),

        // =========================
        // BOTTOM NAVIGATION BAR
        // =========================
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 1,

          onTap: (index) {
            // Home
            if (index == 0) {
              Get.offNamed(
                NameRoutes.homeScreen,
              );
              return;
            }

            // Alertes
            if (index == 1) {
              return;
            }

            // Profile
            if (index == 2) {
              Get.toNamed(
                NameRoutes.profileScreen,
              );
              return;
            }
          },
        ),
      ),
    );
  }
}