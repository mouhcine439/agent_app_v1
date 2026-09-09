import 'package:agentapp/src/Controllers/initial_controller.dart';
import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
    final InitialController initialController = Get.find();
    return BodyWidget(
      scafoldBody: Scaffold(
        appBar: CustomAppbar(
          showBtn: false,
          showBtnSearch: false,
          title: "Home",
          centerTitle: true,
        ),
        body: Obx(
          () => initialController.isUserHasInternet.value
              ? ListView(
                  children: [
                    Center(
                      child: CustomText(
                        title: "Connection online",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                )
              : ListView(
                  children: [
                    Center(
                      child: CustomText(
                        title: "Connection offline",
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
