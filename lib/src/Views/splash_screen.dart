import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
    return BodyWidget(
      scafoldBody: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          elevation: 0,
          title: CustomText(
            title: "Splash Screen",
            fontSize: 15.0,
            fontWeight: FontWeight.normal,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
