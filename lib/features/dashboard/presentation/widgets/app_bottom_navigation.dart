import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_bottom_nav_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/dashboard/data/model/navitem.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItem> items;

  const AppBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavTheme = Theme.of(context).extension<AppBottomNavTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: bottomNavTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkSecondaryText,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: sl<SizeConfig>().rpx(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return _buildNavItem(
                context,
                item,
                isSelected,
                () => onTap(index),
                bottomNavTheme,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavItem item,
    bool isSelected,
    VoidCallback onTap,
    AppBottomNavTheme theme,
  ) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(8)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: sl<SizeConfig>().rpx(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                item.iconPath,
                height: sl<SizeConfig>().iconSize(29),
                width: sl<SizeConfig>().iconSize(25),
                colorFilter: ColorFilter.mode(
                  isSelected ? theme.selectedColor : theme.unselectedColor,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: sl<SizeConfig>().rpx(4)),
              AppTexts(
                text: item.label,
                style: textTheme.accent.copyWith(
                  color: isSelected
                      ? theme.selectedColor
                      : theme.unselectedColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
