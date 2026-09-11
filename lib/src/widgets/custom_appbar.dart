import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    required this.showBtn,
    this.onTap,
    this.onTapSearch,
    required this.showBtnSearch,
    required this.centerTitle,
    this.trailing,
  });
  final String title;
  final bool showBtn, centerTitle, showBtnSearch;
  final void Function()? onTap;
  final void Function()? onTapSearch;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      surfaceTintColor: AppColors.primaryColor,
      leading: showBtn
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.whiteColor,
                size: 25,
              ),
            )
          : null,
      title: CustomText(
        title: title,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      centerTitle: centerTitle,
      actions: trailing == null
          ? null
          : [
              trailing!,
              const SizedBox(width: 16),
            ],
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(1.0),
      //   child: Container(
      //     color: AppColors.primaryColor,
      //     height: 1,
      //   ),
      // ),
      // actions: [
      //   showBtn == true
      //       ? GestureDetector(
      //           onTap: onTap,
      //           child: Container(
      //             decoration: const BoxDecoration(
      //               color: AppColor.primaryColor,
      //               shape: BoxShape.circle,
      //             ),
      //             margin: EdgeInsets.symmetric(
      //               horizontal: MediaQuery.of(context).size.width * 0.015,
      //               vertical: MediaQuery.of(context).size.height * 0.008,
      //             ),
      //             child: const IconButton(
      //               onPressed: null,
      //               icon: Icon(
      //                 Iconsax.add,
      //                 color: AppColor.whiteColor,
      //                 size: 25,
      //               ),
      //             ),
      //           ),
      //         )
      //       : const SizedBox.shrink(),
      //   showBtnSearch == true
      //       ? GestureDetector(
      //           onTap: onTapSearch,
      //           child: Container(
      //             decoration: const BoxDecoration(
      //               color: AppColor.primaryColor,
      //               shape: BoxShape.circle,
      //             ),
      //             margin: EdgeInsets.symmetric(
      //               horizontal: MediaQuery.of(context).size.width * 0.015,
      //               vertical: MediaQuery.of(context).size.height * 0.008,
      //             ),
      //             child: const IconButton(
      //               onPressed: null,
      //               icon: Icon(
      //                 CupertinoIcons.search,
      //                 color: AppColor.whiteColor,
      //                 size: 25,
      //               ),
      //             ),
      //           ),
      //         )
      //       : const SizedBox.shrink(),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}