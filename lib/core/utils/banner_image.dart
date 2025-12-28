import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class BannerImage extends StatelessWidget {
  const BannerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AppImages.pngIcon(
          context,
          Constants.banner,
          155,
          double.infinity,
        ),
      ),
    );
  }
}
