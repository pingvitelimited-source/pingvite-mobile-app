import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/sizeconfig.dart';
import '../../../service_locator_dependencies.dart';

class CardContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final List<Color>? gradientColors;
  final AlignmentGeometry? gradientBegin;
  final AlignmentGeometry? gradientEnd;
  final Color? backgroundColor;
  final BoxShadow? shadow;

  const CardContainerWidget({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.gradientColors,
    this.gradientBegin,
    this.gradientEnd,
    this.backgroundColor,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();

    return Container(
      padding: padding ?? EdgeInsets.all(sizeConfig.rpx(12)),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColors.cardBorderLight,
          width: borderWidth ?? 1.5,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(sizeConfig.rpx(12)),
        gradient: gradientColors != null
            ? LinearGradient(
                colors: gradientColors!,
                begin: gradientBegin ?? Alignment.topLeft,
                end: gradientEnd ?? Alignment.bottomRight,
              )
            : null,
        color:
            backgroundColor ?? (gradientColors == null ? Colors.white : null),
        boxShadow: shadow != null ? [shadow!] : null,
      ),
      child: child,
    );
  }
}
