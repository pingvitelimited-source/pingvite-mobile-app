import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final Color? backgroundColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
    this.onTap,
    this.borderRadius,
    this.elevation,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppCardTheme>()!;

    return Container(
      margin: margin,
      child: Material(
        color: backgroundColor ?? theme.backgroundColor,
        elevation: elevation ?? theme.elevation,
        borderRadius: BorderRadius.circular(borderRadius ?? theme.borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            borderRadius ?? theme.borderRadius,
          ),
          onTap: onTap,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ?? theme.borderColor,
                width: borderWidth ?? 1,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius ?? theme.borderRadius,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
