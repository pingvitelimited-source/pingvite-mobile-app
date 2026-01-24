import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/app_colors.dart';
import '../../utils/sizeconfig.dart';
import '../../../service_locator_dependencies.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String icon;
  final String label;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;

  const SectionHeaderWidget({
    super.key,
    required this.icon,
    required this.label,
    this.padding,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();
    final baseIconSize = (iconSize ?? 48).toDouble();

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: sizeConfig.rpx(16)),
      child: Row(
        children: [
          Container(
            width: sizeConfig.rpx(baseIconSize),
            height: sizeConfig.rpx(baseIconSize),
            decoration: BoxDecoration(
              color: AppColors.blueLightAlpha15,
              borderRadius: BorderRadius.circular(sizeConfig.rpx(12)),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: sizeConfig.rpx(24),
                height: sizeConfig.rpx(24),
                colorFilter: const ColorFilter.mode(
                  AppColors.blue,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: sizeConfig.rpx(12)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: sizeConfig.rpx(16),
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
