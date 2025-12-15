import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';

class VerifiedIcon extends StatelessWidget {
  const VerifiedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: const Icon(
        Icons.check,
        size: 14,
        color: AppColors.darkPrimaryText,
      ),
    );
  }
}
