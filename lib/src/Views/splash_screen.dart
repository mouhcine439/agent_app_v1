import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/routes/name_routes.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        Get.offAllNamed(NameRoutes.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      scafoldBody: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.goldColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: AppColors.primaryColor,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              CustomText(
                title: "Safaa",
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
              const SizedBox(height: 4),
              CustomText(
                title: "Tournées de contrôle terrain",
                fontSize: 13.0,
                fontWeight: FontWeight.normal,
                color: AppColors.greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}