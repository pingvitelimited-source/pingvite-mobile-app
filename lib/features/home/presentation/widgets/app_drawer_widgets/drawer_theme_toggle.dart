import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/theme_helper.dart';
import 'package:provider/provider.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/theme_controller.dart';

class DrawerThemeToggle extends StatelessWidget {
  const DrawerThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    final isDark = ThemeHelper.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.white.withValues(alpha: 0.08)
            : AppColors.black.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
            color: ThemeHelper.accentTextColor(context),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AppTexts(
              text: isDark
                  ? Constants.drawerDarkMode
                  : Constants.drawerLightMode,
              style: Theme.of(context).extension<AppTextTheme>()!.body.copyWith(
                color: ThemeHelper.primaryTextColor(context),
              ),
            ),
          ),
          Switch(
            value: isDark,
            onChanged: (_) => themeController.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
