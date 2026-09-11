import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/models/checkpoint_model.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CheckpointTile extends StatelessWidget {
  const CheckpointTile({
    super.key,
    required this.checkpoint,
    this.onTap,
  });

  final CheckpointModel checkpoint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDone =
        checkpoint.status == CheckpointStatus.done;

    final bool isCurrent =
        checkpoint.status == CheckpointStatus.inProgress;

    final bool isPending =
        checkpoint.status == CheckpointStatus.pending;

    final Color iconColor = isDone
        ? AppColors.valideColor
        : isCurrent
            ? AppColors.goldColor
            : AppColors.greyColor;

    return Opacity(
      opacity: isPending ? 0.55 : 1,
      child: InkWell(
        onTap: isPending ? null : onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isCurrent
                  ? AppColors.goldColor.withValues(alpha: 0.6)
                  : AppColors.greyColor.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDone
                      ? Icons.check_rounded
                      : isCurrent
                          ? Icons.location_on_outlined
                          : Icons.lock_outline_rounded,
                  color: iconColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: checkpoint.title,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.greyColor,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: CustomText(
                            title: checkpoint.location,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.greyColorFoncait,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                isPending
                    ? Icons.lock_outline_rounded
                    : Icons.chevron_right_rounded,
                color: isPending
                    ? AppColors.greyColor
                    : AppColors.blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}