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
      fit: BoxFit.cover,
    );
  }

  // For SVG icons that need theme-based color
  static Widget svgIcon(
    BuildContext context,
    String svgPath,
    double height,
    double width, [
    Color? color,
  ]) {
    return SvgPicture.asset(
      svgPath,
      height: sl<SizeConfig>().iconSize(height),
      width: sl<SizeConfig>().iconSize(width),
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  static Widget pngIcon(
    BuildContext context,
    String iconPath,
    double height,
    double width, {
    bool applyColor = true,
    double? scale,
    Color? color,
  }) {
    final imageTheme = Theme.of(context).extension<AppImageTheme>()!;

    Widget imageWidget = Image.asset(
      iconPath,
      height: sl<SizeConfig>().iconSize(height),
      width: sl<SizeConfig>().iconSize(width),
      color: applyColor ? (color ?? imageTheme.iconColor) : null,
    );
    if (scale != null) {
      imageWidget = Transform.scale(scale: scale, child: imageWidget);
    }
    return imageWidget;
  }
}
