import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_input_decorators.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class ContactTypeDropdown extends StatelessWidget {
  final AppButtonTheme buttonTheme;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const ContactTypeDropdown({
    super.key,
    required this.buttonTheme,
    this.selectedValue,
    this.onChanged,
  });

  static const List<String> _contactTypes = [
    'Family',
    'Friend',
    'Work',
    'Business',
    'VIP',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return FormBuilderDropdown<String>(
      name: 'contact_type',
      initialValue: selectedValue,
      isExpanded: true,
      icon: const SizedBox.shrink(),
      items: _contactTypes
          .map(
            (type) => DropdownMenuItem<String>(
              value: type,
              child: Text(type, style: textTheme.body),
            ),
          )
          .toList(),
      decoration:
          AppInputDecoration.build(
            hintText: '',
            prefixIcon: Icon(
              Icons.star_border_rounded,
              size: 20.rpx,
              color: AppColors.grey,
            ),
            suffixIcon: null,
            buttonTheme: buttonTheme,
            textTheme: textTheme,
          ).copyWith(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.rpx,
              vertical: 14.rpx,
            ),
            suffixIcon: Transform.rotate(
              angle: -math.pi / 2,
              child: Padding(
                padding: EdgeInsets.all(18.rpx),
                child: AppImages.svgIcon(context, Constants.backArrow, 15, 12),
              ),
            ),
          ),
      hint: Row(
        children: [
          Text(
            'Contact Type',
            style: textTheme.body.copyWith(
              color: AppColors.grey.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'Please select a contact type',
        ),
      ]),
      onChanged: onChanged,
    );
  }
}
