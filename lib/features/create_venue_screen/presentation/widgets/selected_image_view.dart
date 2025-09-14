import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SelectedImageView extends StatelessWidget {
  final File selectedImage;
  final VoidCallback onRemove;

  const SelectedImageView({
    super.key,
    required this.selectedImage,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: sl<SizeConfig>().rpx(50),
        height: sl<SizeConfig>().rpx(50),
        child: Stack(
          clipBehavior: Clip.none, // Allow button to overflow outside
          children: [
            // Small square image
            Container(
              width: sl<SizeConfig>().rpx(50),
              height: sl<SizeConfig>().rpx(50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.unSelectedTabText.withValues(alpha: 0.4),
                  width: 1,
                ),
                image: DecorationImage(
                  image: FileImage(selectedImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Cancel button positioned RELATIVE TO IMAGE
            Positioned(
              top: -6,
              right: -6,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.lightGradient,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.lightbackground,
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.lightbackground,
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//AppColors.black.withValues(alpha: 0.7),