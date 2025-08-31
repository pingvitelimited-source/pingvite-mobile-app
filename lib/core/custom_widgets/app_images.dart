import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pingvite/core/theme/app_image_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppImages {
  // For regular PNG images (no color - like your logo, banners, photos)
  static Widget image(String imagePath, double height, double width) {
    return Image.asset(
      imagePath,
      height: sl<SizeConfig>().rpx(height),
      width: sl<SizeConfig>().rpx(width),
    );
  }

  // For SVG icons that need theme-based color
  static Widget svgIcon(
    BuildContext context,
    String svgPath,
    double height,
    double width,
  ) {
    return SvgPicture.asset(
      svgPath,
      height: sl<SizeConfig>().iconSize(height),
      width: sl<SizeConfig>().iconSize(width),
    );
  }

  // For PNG icons that need theme-based color (fallback)
  static Widget pngIcon(
    BuildContext context,
    String iconPath,
    double height,
    double width,
  ) {
    final imageTheme = Theme.of(context).extension<AppImageTheme>()!;

    return Image.asset(
      iconPath,
      height: sl<SizeConfig>().iconSize(height),
      width: sl<SizeConfig>().iconSize(width),
      color: imageTheme.iconColor,
    );
  }
}
