import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_input_decorators.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

import 'dart:math' as math;

class CustomDropdown<T> extends StatelessWidget {
  final String name;
  final String hintText;
  final List<T> items;
  final AppButtonTheme buttonTheme;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final List<String? Function(T?)>? validators;

  const CustomDropdown({
    super.key,
    required this.name,
    required this.hintText,
    required this.items,
    required this.buttonTheme,
    this.initialValue,
    this.onChanged,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<T>(
      name: name,
      initialValue: initialValue,
      isExpanded: true,
      icon: const SizedBox.shrink(),
      dropdownColor: Colors.white,
      items: items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                e.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightPrimaryText,
                ),
              ),
            ),
          )
          .toList(),
      decoration:
          AppInputDecoration.build(
            hintText: '',
            prefixIcon: null,
            suffixIcon: null,
            buttonTheme: buttonTheme,
          ).copyWith(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: sl<SizeConfig>().rpx(16),
              vertical: sl<SizeConfig>().rpx(14),
            ),
            suffixIcon: Transform.rotate(
              angle: -math.pi / 2,
              child: Padding(
                padding: EdgeInsets.all(sl<SizeConfig>().rpx(18)),
                child: AppImages.svgIcon(
                  context,
                  Constants.backArrow,
                  15,
                  12,
                  AppColors.lightPrimaryText,
                ),
              ),
            ),
          ),
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          hintText,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.lightSecondaryText),
        ),
      ),

      validator: validators != null
          ? FormBuilderValidators.compose(validators!)
          : null,
      onChanged: onChanged,
    );
  }
}
