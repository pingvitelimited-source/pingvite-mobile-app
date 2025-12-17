import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      height: sl<SizeConfig>().rpx(80),
      padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(20)),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.lightGradient, AppColors.darkGradient],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTexts(text: 'Welcome, John Doe', style: textTheme.bold),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.darkPrimaryText),
          ),
        ],
      ),
    );
  }
}
