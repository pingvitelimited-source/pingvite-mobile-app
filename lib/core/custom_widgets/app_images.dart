import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppImages {
  static Widget image(
    String imagePath, [
    double? height,
    double? width,
    BoxFit? fit,
  ]) {
    return Image.asset(
      imagePath,
      height: height != null ? sl<SizeConfig>().rpx(height) : null,
      width: width != null ? sl<SizeConfig>().rpx(width) : null,
      fit: fit,
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
      height: sl<SizeConfig>().isz(height),
      width: sl<SizeConfig>().isz(width),
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
    bool applyColor = false,
    double? scale,
    Color? color,
  }) {
    final resolvedWidth = width == double.infinity
        ? double.infinity
        : sl<SizeConfig>().isz(width);

    final resolvedHeight = sl<SizeConfig>().isz(height);

    Widget imageWidget = Image.asset(
      iconPath,
      height: resolvedHeight,
      width: resolvedWidth,
      fit: BoxFit.cover, // 🔥 IMPORTANT
      color: applyColor ? color : null,
    );

    if (scale != null) {
      imageWidget = Transform.scale(scale: scale, child: imageWidget);
    }
    return imageWidget;
  }
}
