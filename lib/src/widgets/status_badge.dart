import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/tour_model.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final TourStatus status;

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color textColor;
    late final String label;

    switch (status) {
      case TourStatus.todo:
        bg = AppColors.badgeTodoBg;
        textColor = AppColors.badgeTodoText;
        label = "À faire";
        break;
      case TourStatus.inProgress:
        bg = AppColors.primaryColor;
        textColor = AppColors.whiteColor;
        label = "En cours";
        break;
      case TourStatus.done:
        bg = AppColors.badgeDoneBg;
        textColor = AppColors.badgeDoneText;
        label = "Terminé";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: CustomText(
        title: label,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}