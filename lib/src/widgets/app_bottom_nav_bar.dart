import 'package:agentapp/src/constants/app_colors.dart';
import 'package:agentapp/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

/// Barre de navigation basse commune aux écrans Tournées / Alertes / Profil.
/// Pour l'instant seul l'onglet "Tournées" est branché ; les autres
/// afficheront un message temporaire tant que leurs écrans ne sont pas prêts.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  final int currentIndex;
  final void Function(int index)? onTap;

  static const _items = [
    _NavItem(icon: Icons.checklist_rounded, label: "Tournées"),
    _NavItem(icon: Icons.notifications_none_rounded, label: "Alertes"),
    _NavItem(icon: Icons.person_outline_rounded, label: "Profil"),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border(
          top: BorderSide(color: AppColors.greyColor.withValues(alpha: 0.25)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(_items.length, (index) {
              final bool isActive = index == currentIndex;
              final item = _items[index];
              final Color color =
                  isActive ? AppColors.goldColor : AppColors.greyColor;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap?.call(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon, color: color, size: 24),
                      const SizedBox(height: 4),
                      CustomText(
                        title: item.label,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}