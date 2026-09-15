import 'package:agentapp/src/Controllers/initial_controller.dart';
import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/tour_model.dart';
import 'package:agentapp/src/routes/name_routes.dart';
import 'package:agentapp/src/widgets/app_bottom_nav_bar.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:agentapp/src/widgets/tour_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InitialController initialController =
        Get.find<InitialController>();

    return BodyWidget(
      scafoldBody: Scaffold(
        backgroundColor: AppColors.bgColor,

        // --------------------------------------------------
        // APP BAR
        // --------------------------------------------------
        appBar: CustomAppbar(
          showBtn: false,
          showBtnSearch: false,
          centerTitle: false,
          title: 'Mes tournées',

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Statut connexion
              Obx(
                () {
                  final bool isOnline =
                      initialController.isUserHasInternet.value;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withValues(
                        alpha: 0.12,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isOnline
                              ? Icons.wifi_rounded
                              : Icons.wifi_off_rounded,
                          color: isOnline
                              ? AppColors.valideColor
                              : AppColors.goldColor,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          title: isOnline
                              ? 'En ligne'
                              : 'Hors ligne',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(width: 8),

              // Utilisateur
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.whiteColor,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    CustomText(
                      title: 'J. Dupont',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // --------------------------------------------------
        // BODY
        // --------------------------------------------------
        body: Obx(
          () {
            final bool isOnline =
                initialController.isUserHasInternet.value;

            return Column(
              children: [
                // Bandeau offline
                if (!isOnline)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.goldColor.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.goldColor.withValues(
                          alpha: 0.30,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          color: AppColors.goldColor,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomText(
                            title:
                                'Mode hors ligne : les données seront synchronisées lorsque la connexion sera rétablie.',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Liste des tournées
                Expanded(
                  child: mockTours.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          physics:
                              const BouncingScrollPhysics(),
                          itemCount: mockTours.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            final tour = mockTours[index];

                            return TourCard(
                              tour: tour,
                              onTap: () {
                                Get.toNamed(
                                  NameRoutes.tourDetailScreen,
                                  arguments: tour,
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),

        // --------------------------------------------------
        // BOTTOM NAVIGATION
        // --------------------------------------------------
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 0) {
              return;
            }

            if (index == 1) {
              Get.toNamed(NameRoutes.alertsScreen);
              return;
            }

            if (index == 2) {
              Get.toNamed(NameRoutes.profileScreen);
              return;
            }
          },
        ),
      ),
    );
  }

  // --------------------------------------------------
  // EMPTY STATE
  // --------------------------------------------------
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.route_outlined,
            size: 50,
            color: AppColors.greyColor,
          ),
          const SizedBox(height: 12),
          const CustomText(
            title: 'Aucune tournée',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          CustomText(
            title:
                'Aucune tournée ne vous a été affectée.',
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: AppColors.greyColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}