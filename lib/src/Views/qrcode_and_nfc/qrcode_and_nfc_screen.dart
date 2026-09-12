import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/widgets/body_widget.dart';
import 'package:agentapp/src/widgets/custom_appbar.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrcodeAndNfcScreen extends StatelessWidget {
  const QrcodeAndNfcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;
    return BodyWidget(
      scafoldBody: Scaffold(
        appBar: CustomAppbar(
          title: "Qr Code / Nfc",
          showBtn: true,
          showBtnAction: false,
          centerTitle: false,
          icon: Icons.person,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15.0,
          children: [
            CustomText(
              title:
                  "Sélectionner votre type pour valider votre tour presentiel pour bonne trasabiliter",
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            // code qr
            GestureDetector(
              onTap: () {},
              child: Container(
                width: w,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppColors.greyColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15.0,
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: AppColors.purpule,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.qr_code,
                        color: AppColors.whiteColor,
                        size: 30.0,
                      ),
                    ),
                    CustomText(
                      title: "Scanne Avec Code QR",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),
              ),
            ),
            // nfc
            GestureDetector(
              onTap: () {},
              child: Container(
                width: w,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppColors.greyColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15.0,
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: AppColors.purpule,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.nfc,
                        color: AppColors.whiteColor,
                        size: 30.0,
                      ),
                    ),
                    CustomText(
                      title: "Scanne Avec NFC",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 10.0),
      ),
    );
  }
}
