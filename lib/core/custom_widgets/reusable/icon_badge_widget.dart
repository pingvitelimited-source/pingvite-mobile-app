import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/app_colors.dart';
import '../../utils/sizeconfig.dart';
import '../../../service_locator_dependencies.dart';

class IconBadgeWidget extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? backgroundColor;
  final Color? iconColor;

  const IconBadgeWidget({
    super.key,
    required this.icon,
    this.size,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();
    final badgeSize = (size ?? 48).toDouble();

    return Container(
      width: sizeConfig.rpx(badgeSize),
      height: sizeConfig.rpx(badgeSize),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.blueLightAlpha15,
        borderRadius: BorderRadius.circular(sizeConfig.rpx(12)),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: sizeConfig.rpx(24),
          height: sizeConfig.rpx(24),
          colorFilter: ColorFilter.mode(
            iconColor ?? AppColors.blue,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
