import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
    return BodyWidget(
      scafoldBody: Scaffold(
        appBar: CustomAppbar(
          title: "Profile",
          showBtn: true,
          showBtnAction: false,
          centerTitle: false,
          icon: Icons.person,
        ),
        body: ListView(
          children: [
            SizedBox(height: h * 0.01),
            Card(
              color: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                  color: AppColors.greyColor.withValues(alpha: 0.3),
                ),
              ),
              elevation: 0.0,
              child: ListTile(
                leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    title: "ME",
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blackColor,
                  ),
                ),
                title: CustomText(
                  title: "Mouhcine Elbadssi",
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
                subtitle: CustomText(
                  title: "mouhcine.elbadssi@gmail.com",
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.blackColor,
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: AppColors.purpule,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.edit,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CustomText(
              title: "Paramétres",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
            SizedBox(height: 5.0),
            Card(
              color: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                  color: AppColors.greyColor.withValues(alpha: 0.3),
                ),
              ),
              elevation: 0.0,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.password_rounded,
                      color: AppColors.primaryColor,
                    ),
                    title: CustomText(
                      title: "Changement de mot de passe",
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: AppColors.blackColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.blackColor,
                      size: 18.0,
                    ),
                  ),
                  Divider(
                    height: 0.0,
                    color: AppColors.greyColor.withValues(alpha: 0.3),
                    endIndent: 40.0,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.logout_rounded,
                      color: AppColors.errorColor,
                    ),
                    title: CustomText(
                      title: "Déconnexion",
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: AppColors.errorColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.errorColor,
                      size: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 10.0),
      ),
    );
  }
}
