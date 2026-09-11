import 'package:agentapp/src/Controllers/tour_detail_controller.dart';
import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/checkpoint_model.dart';
import 'package:agentapp/src/models/tour_model.dart';
import 'package:agentapp/src/routes/name_routes.dart';
import 'package:agentapp/src/widgets/app_bottom_nav_bar.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/checkpoint_tile.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:agentapp/src/widgets/tour_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TourDetailScreen extends StatefulWidget {
  const TourDetailScreen({
    super.key,
  });

  @override
  State<TourDetailScreen> createState() =>
      _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  late final TourDetailController controller;

  @override
  void initState() {
    super.initState();

    // Création du controller sans tag.
    controller = Get.put(TourDetailController());

    final arguments = Get.arguments;

    TourModel tour;

    // Si Home envoie directement le TourModel
    if (arguments is TourModel) {
      tour = arguments;
    }

    // Si les arguments sont envoyés sous forme de Map
    else if (arguments is Map<String, dynamic> &&
        arguments['tour'] is TourModel) {
      tour = arguments['tour'] as TourModel;
    }

    // Si aucun argument n'est envoyé
    else {
      tour = mockTours.first;
    }

    controller.initialize(tour);
  }

  @override
  void dispose() {
    // Suppression du controller.
    Get.delete<TourDetailController>();

    super.dispose();
  }

  void _openCheckpoint(
    CheckpointModel checkpoint,
  ) {
    if (!controller.canOpenCheckpoint(checkpoint)) {
      Get.snackbar(
        'Point non disponible',
        'Terminez le point précédent avant de continuer.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.whiteColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );

      return;
    }

    Get.toNamed(
      NameRoutes.scanScreen,
      arguments: {
        'tour': controller.tour,
        'checkpoint': checkpoint,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      scafoldBody: Scaffold(
        backgroundColor: AppColors.bgColor,

        // =====================================================
        // APP BAR
        // =====================================================

        appBar: CustomAppbar(
          title: controller.tour.title,
          showBtn: true,
          showBtnSearch: false,
          centerTitle: false,
        ),

        // =====================================================
        // BODY
        // =====================================================

        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // -------------------------------------------------
                // DESCRIPTION DE LA TOUR
                // -------------------------------------------------

                CustomText(
                  title: controller.tour.subtitle,
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.greyColor,
                ),

                const SizedBox(height: 12),

                // -------------------------------------------------
                // PROGRESSION
                // -------------------------------------------------

                TourProgressBar(
                  value: controller.progress,
                ),

                const SizedBox(height: 10),

                // -------------------------------------------------
                // NOMBRE DE CHECKPOINTS
                // -------------------------------------------------

                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 16,
                      color: AppColors.valideColor,
                    ),

                    const SizedBox(width: 6),

                    CustomText(
                      title:
                          '${controller.completedCount}/${controller.checkpoints.length} points terminés',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // -------------------------------------------------
                // TITRE
                // -------------------------------------------------

                const CustomText(
                  title: 'Points de contrôle',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),

                const SizedBox(height: 12),

                // -------------------------------------------------
                // LISTE DES CHECKPOINTS
                // -------------------------------------------------

                Expanded(
                  child: controller.checkpoints.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          physics:
                              const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount:
                              controller.checkpoints.length,
                          itemBuilder:
                              (context, index) {
                            final checkpoint =
                                controller.checkpoints[index];

                            return CheckpointTile(
                              checkpoint: checkpoint,
                              onTap: () {
                                _openCheckpoint(
                                  checkpoint,
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),

        // =====================================================
        // BOTTOM NAVIGATION
        // =====================================================

       bottomNavigationBar: AppBottomNavBar(
  currentIndex: 0,
  onTap: (index) {
    if (index == 0) {
      Get.back();
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

  // ===========================================================
  // EMPTY STATE
  // ===========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 48,
            color: AppColors.greyColor,
          ),

          const SizedBox(height: 12),

          const CustomText(
            title: 'Aucun point de contrôle',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          CustomText(
            title:
                'Cette tournée ne contient aucun point de contrôle.',
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.greyColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}