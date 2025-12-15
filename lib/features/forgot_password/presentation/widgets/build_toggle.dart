import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class BuildToggle extends StatelessWidget {
  final bool isPhone;
  final bool isDisabled;
  final ValueChanged<bool> onChanged;

  const BuildToggle({
    super.key,
    required this.isPhone,
    required this.onChanged,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return AbsorbPointer(
      absorbing: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1,
        child: Container(
          height: sl<SizeConfig>().rpx(44),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.unSelectedTabText),
          ),
          child: Row(
            children: [
              _toggleItem(
                text: Constants.resetEmail,
                active: !isPhone,
                onTap: () => onChanged(false),
                textTheme: textTheme,
              ),
              _toggleItem(
                text: Constants.phone,
                active: isPhone,
                onTap: () => onChanged(true),
                textTheme: textTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _toggleItem({
  required String text,
  required bool active,
  required VoidCallback onTap,
  required AppTextTheme textTheme,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: active ? AppColors.blue : AppColors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        alignment: Alignment.center,
        child: AppTexts(
          text: text,
          style: active
              ? textTheme.accent.copyWith(color: AppColors.white)
              : textTheme.accent.copyWith(color: AppColors.grey),
        ),
      ),
    ),
  );
}
