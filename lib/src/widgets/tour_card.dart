import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/tour_model.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:agentapp/src/widgets/status_badge.dart';
import 'package:flutter/material.dart';

class TourCard extends StatelessWidget {
  const TourCard({
    super.key,
    required this.tour,
    this.onTap,
  });

  final TourModel tour;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: tour.title,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    title: tour.subtitle,
                    fontSize: 13.0,
                    fontWeight: FontWeight.normal,
                    color: AppColors.greyColorFoncait,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            StatusBadge(status: tour.status),
          ],
        ),
      ),
    );
  }
}