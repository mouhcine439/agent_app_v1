import 'package:agentapp/src/Controllers/initial_controller.dart';
import 'package:agentapp/src/Controllers/scan_controller.dart';
import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/checkpoint_model.dart';
import 'package:agentapp/src/models/tour_model.dart';
import 'package:agentapp/src/routes/name_routes.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_button.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    super.key,
  });

  @override
  State<ScanScreen> createState() =>
      _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late final ScanController controller;
  late final InitialController connection;
  late final String _controllerTag;

  @override
  void initState() {
    super.initState();

    _controllerTag =
        DateTime.now().microsecondsSinceEpoch.toString();

    controller = Get.put(
      ScanController(),
      tag: _controllerTag,
    );

    connection = Get.find<InitialController>();

    final arguments =
        Get.arguments as Map<String, dynamic>? ?? {};

    final TourModel tour =
        arguments['tour'] is TourModel
            ? arguments['tour'] as TourModel
            : mockTours.first;

    final CheckpointModel checkpoint =
        arguments['checkpoint'] is CheckpointModel
            ? arguments['checkpoint']
                as CheckpointModel
            : mockCheckpointsFor(tour.id).first;

    controller.initialize(
      selectedTour: tour,
      selectedCheckpoint: checkpoint,
    );
  }

  @override
  void dispose() {
    Get.delete<ScanController>(
      tag: _controllerTag,
    );

    super.dispose();
  }

  void _continue() {
    Get.snackbar(
      'Scan validé',
      'Le questionnaire sera disponible dans l’écran suivant.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
    );

    // Plus tard :
    //
    // Get.toNamed(
    //   NameRoutes.questionnaireScreen,
    //   arguments: {
    //     'tour': controller.tour,
    //     'checkpoint': controller.checkpoint,
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      scafoldBody: Scaffold(
        backgroundColor: AppColors.bgColor,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.bgColor,
          surfaceTintColor: AppColors.bgColor,

          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.blackColor,
            ),
          ),

          title: CustomText(
            title: controller.checkpoint.title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),

          actions: [
            Obx(
              () => connection.isUserHasInternet.value
                  ? const SizedBox.shrink()
                  : Padding(
                      padding:
                          const EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.wifi_off_rounded,
                            color: AppColors.goldColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const CustomText(
                            title: 'Hors ligne',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldColor,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),

        body: Obx(
          () => SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildHeader(),

                  const SizedBox(height: 16),

                  Expanded(
                    child: _buildScanner(),
                  ),

                  const SizedBox(height: 16),

                  _buildVerificationCard(),

                  const SizedBox(height: 16),

                  CustomButton(
                    onPressed: controller.isVerified.value
                        ? _continue
                        : null,
                    bgColorButton:
                        controller.isVerified.value
                            ? AppColors.goldColor
                            : AppColors.greyColor
                                .withValues(alpha: 0.35),
                    title: 'Continuer',
                    colorText: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const CustomText(
          title: 'Vérification du point de contrôle',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.blackColor,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 6),

        CustomText(
          title: controller.checkpoint.description ??
              'Scannez le QR Code présent sur le site.',
          fontSize: 12.5,
          fontWeight: FontWeight.normal,
          color: AppColors.greyColorFoncait,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildScanner() {
    return GestureDetector(
      onTap: controller.simulateScan,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 390,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          children: [
            const _ScannerCorners(),

            Center(
              child: controller.isScanning.value
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.goldColor,
                        ),
                        SizedBox(height: 18),
                        CustomText(
                          title: 'Analyse en cours...',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    )
                  : controller.isVerified.value
                      ? const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.valideColor,
                              size: 64,
                            ),
                            SizedBox(height: 12),
                            CustomText(
                              title: 'QR Code validé',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        )
                      : const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.qr_code_scanner_rounded,
                              color: AppColors.whiteColor,
                              size: 54,
                            ),
                            SizedBox(height: 14),
                            CustomText(
                              title: 'Touchez pour scanner',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationCard() {
    final bool verified =
        controller.isVerified.value;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: verified
            ? AppColors.valideColor
                .withValues(alpha: 0.08)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: verified
              ? AppColors.valideColor
              : AppColors.greyColor
                  .withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          Icon(
            verified
                ? Icons.location_on_rounded
                : Icons.location_off_outlined,
            color: verified
                ? AppColors.valideColor
                : AppColors.greyColorFoncait,
            size: 22,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: verified
                      ? 'Position vérifiée'
                      : 'Position en attente',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
                const SizedBox(height: 3),
                CustomText(
                  title: verified
                      ? 'Vous êtes à proximité du point.'
                      : 'La position sera vérifiée après le scan.',
                  fontSize: 11.5,
                  fontWeight: FontWeight.normal,
                  color: AppColors.greyColorFoncait,
                ),
              ],
            ),
          ),

          CustomText(
            title:
                '${controller.distance.value.toStringAsFixed(0)} m',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: verified
                ? AppColors.valideColor
                : AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}

class _ScannerCorners extends StatelessWidget {
  const _ScannerCorners();

  @override
  Widget build(BuildContext context) {
    const double size = 32;
    const double thickness = 3;

    const BorderSide side = BorderSide(
      color: AppColors.goldColor,
      width: thickness,
    );

    return Stack(
      children: [
        _corner(
          top: 28,
          left: 28,
          border: const Border(
            top: side,
            left: side,
          ),
        ),
        _corner(
          top: 28,
          right: 28,
          border: const Border(
            top: side,
            right: side,
          ),
        ),
        _corner(
          bottom: 28,
          left: 28,
          border: const Border(
            bottom: side,
            left: side,
          ),
        ),
        _corner(
          bottom: 28,
          right: 28,
          border: const Border(
            bottom: side,
            right: side,
          ),
        ),
      ],
    );
  }

  static Widget _corner({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Border border,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: border,
        ),
      ),
    );
  }

  static const double size = 32;
}