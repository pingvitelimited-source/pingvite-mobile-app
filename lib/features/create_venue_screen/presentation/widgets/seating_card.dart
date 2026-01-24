import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/custom_dropdown.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SeatingCard extends StatelessWidget {
  final int index;
  final AppButtonTheme buttonTheme;
  final bool showDelete;
  final VoidCallback onDelete;
  final Animation<double> animation;

  const SeatingCard({
    super.key,
    required this.index,
    required this.buttonTheme,
    required this.showDelete,
    required this.onDelete,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: FadeTransition(
        opacity: animation,
        child: Container(
          padding: EdgeInsets.all(sl<SizeConfig>().rpx(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(12)),
            border: Border.all(
              color: AppColors.grey.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with delete button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTexts(
                    text: '${Constants.seatingCategory} ${index + 1}',
                    style: textTheme.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (showDelete)
                    GestureDetector(
                      onTap: onDelete,
                      child: AppImages.svgIcon(
                        context,
                        Constants.deleteIcon,
                        20,
                        20,
                        AppColors.red,
                      ),
                    ),
                ],
              ),
              SizedBox(height: sl<SizeConfig>().rpx(12)),

              // Seating Category Dropdown
              CustomDropdown<String>(
                name: 'seatingCategory_$index',
                hintText: Constants.seatingCategory,
                buttonTheme: buttonTheme,
                items: const [
                  Constants.vip,
                  Constants.general,
                  Constants.premium,
                  Constants.economy,
                ],
                onChanged: (val) => debugPrint('Category $index: $val'),
              ),
              SizedBox(height: sl<SizeConfig>().rpx(12)),

              // No. of Seats Dropdown
              CustomDropdown<String>(
                name: 'noOfSeats_$index',
                hintText: Constants.noOfSeats,
                buttonTheme: buttonTheme,
                items: const [
                  Constants.seatOption50,
                  Constants.seatOption100,
                  Constants.seatOption200,
                  Constants.seatOption500,
                  Constants.seatOption1000,
                  Constants.seatOption2000Plus,
                ],
                onChanged: (val) => debugPrint('Seats $index: $val'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
