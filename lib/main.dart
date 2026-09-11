import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/Controllers/initial_controller.dart';
import 'src/constants/app_colors.dart';
import 'src/routes/app_routes.dart';
import 'src/routes/name_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InitialController());

    return GetMaterialApp(
      title: 'Agent App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.bgColor,
        useMaterial3: true,
      ),
      initialRoute: NameRoutes.splashScreen,
      getPages: AppRoutes.pages,
    );
  }
}