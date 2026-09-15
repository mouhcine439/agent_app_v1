import 'package:agentapp/src/Controllers/profile_controller.dart';
import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/widgets/app_bottom_nav_bar.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agentapp/src/routes/name_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      ProfileController(),
    );
  }

  @override
  void dispose() {
    Get.delete<ProfileController>();
    super.dispose();
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
          title: 'Profil',
          showBtn: false,
          showBtnSearch: false,
          centerTitle: false,
        ),

        // =========================
        // BODY
        // =========================
        body: Obx(
          () => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // =========================
              // PROFILE ICON
              // =========================
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =========================
              // NAME
              // =========================
              Center(
                child: CustomText(
                  title: controller.name,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
              ),

              const SizedBox(height: 5),

              // =========================
              // ROLE
              // =========================
              Center(
                child: CustomText(
                  title: controller.role,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: AppColors.greyColor,
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // EMAIL
              // =========================
              _ProfileItem(
                icon: Icons.email_outlined,
                title: 'Email',
                value: controller.email,
              ),

              const SizedBox(height: 10),

              // =========================
              // NOTIFICATIONS
              // =========================
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.greyColor.withOpacity(0.25),
                  ),
                ),
                child: SwitchListTile(
                  secondary: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.primaryColor,
                  ),
                  title: const Text(
                    'Notifications',
                  ),
                  subtitle: const Text(
                    'Recevoir les notifications',
                  ),
                  value: controller.notificationsEnabled.value,
                  onChanged: controller.toggleNotifications,
                ),
              ),

              const SizedBox(height: 10),

              // =========================
              // MODE HORS LIGNE
              // =========================
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.greyColor.withOpacity(0.25),
                  ),
                ),
                child: SwitchListTile(
                  secondary: const Icon(
                    Icons.cloud_off_outlined,
                    color: AppColors.primaryColor,
                  ),
                  title: const Text(
                    'Mode hors ligne',
                  ),
                  subtitle: const Text(
                    'Utiliser les données locales',
                  ),
                  value: controller.offlineModeEnabled.value,
                  onChanged: controller.toggleOfflineMode,
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // LOGOUT
              // =========================
              SizedBox(
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Get.offAllNamed(
                      '/loginScreen',
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                  label: const Text(
                    'Se déconnecter',
                  ),
                ),
              ),
            ],
          ),
        ),

        // =========================
        // BOTTOM NAVIGATION BAR
        // =========================
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 2,

          onTap: (index) {
            // =========================
            // HOME
            // =========================
            if (index == 0) {
              Get.offNamed(
                NameRoutes.homeScreen,
              );
              return;
            }

            // =========================
            // ALERTES
            // =========================
            if (index == 1) {
              Get.toNamed(
                NameRoutes.alertsScreen,
              );
              return;
            }

            // =========================
            // PROFIL
            // =========================
            if (index == 2) {
              return;
            }
          },
        ),
      ),
    );
  }
}

// ======================================================
// PROFILE ITEM
// ======================================================

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.greyColor.withOpacity(0.25),
        ),
      ),

      child: Row(
        children: [
          // =========================
          // ICON
          // =========================
          Icon(
            icon,
            color: AppColors.primaryColor,
          ),

          const SizedBox(width: 12),

          // =========================
          // TEXT
          // =========================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: AppColors.greyColor,
                ),

                const SizedBox(height: 3),

                CustomText(
                  title: value,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}