import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppInputDecoration {
  static InputDecoration build({
    required String hintText,
    required Widget? prefixIcon,
    required Widget? suffixIcon,
    required AppButtonTheme buttonTheme,
  }) {
    return InputDecoration(
      hintText: hintText,
      isDense: true,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sl<SizeConfig>().rpx(12),
              ),
              child: prefixIcon,
            )
          : null,
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sl<SizeConfig>().rpx(12),
              ),
              child: suffixIcon,
            )
          : null,
      prefixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(12)),
        borderSide: BorderSide(color: buttonTheme.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(12)),
        borderSide: BorderSide(color: buttonTheme.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(12)),
        borderSide: BorderSide(color: buttonTheme.focusedBorderColor, width: 2),
      ),
      filled: true,
      fillColor: buttonTheme.fillColor,
      contentPadding: EdgeInsets.symmetric(
        horizontal: sl<SizeConfig>().rpx(16),
        vertical: sl<SizeConfig>().rpx(16),
      ),
    );
  }
}
