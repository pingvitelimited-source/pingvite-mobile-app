import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pingvite/core/theme/app_image_theme.dart';
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
  // Now automatically uses theme iconColor when no color is specified
  static Widget svgIcon(
    BuildContext context,
    String svgPath,
    double height,
    double width, [
    Color? color,
    bool applyThemeColor = true,
  ]) {
    final imageTheme = Theme.of(context).extension<AppImageTheme>()!;
    final effectiveColor =
        color ?? (applyThemeColor ? imageTheme.iconColor : null);

    return SvgPicture.asset(
      svgPath,
      height: sl<SizeConfig>().isz(height),
      width: sl<SizeConfig>().isz(width),
      colorFilter: effectiveColor != null
          ? ColorFilter.mode(effectiveColor, BlendMode.srcIn)
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
