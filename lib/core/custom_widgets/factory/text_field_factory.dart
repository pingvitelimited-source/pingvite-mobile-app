import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_textfield.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/date_time_picker_util.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class TextFieldFactory {
  static Widget email({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return CustomTextField(
      name: 'email',
      hintText: 'Registered email ID',
      buttonTheme: buttonTheme,
      prefixIcon: AppImages.svgIcon(
        context,
        Constants.email,
        16,
        12,
        AppColors.grey,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validators: [
        FormBuilderValidators.required(errorText: 'Email is required'),
        FormBuilderValidators.email(errorText: 'Please enter a valid email'),
      ],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
      textStyle: textTheme.body,
      hintStyle: textTheme.body,
    );
  }

  // Password Field
  static final Map<String, ValueNotifier<bool>> _passwordVisibilityNotifiers =
      {};
  static Widget password({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
    String fieldKey = 'password',
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    _passwordVisibilityNotifiers[fieldKey] ??= ValueNotifier<bool>(true);
    final obscureNotifier = _passwordVisibilityNotifiers[fieldKey]!;
    return ValueListenableBuilder(
      valueListenable: obscureNotifier,
      builder: (context, isObscure, child) {
        return CustomTextField(
          name: fieldKey,
          hintText: 'Password',
          buttonTheme: buttonTheme,
          prefixIcon: AppImages.svgIcon(
            context,
            Constants.password,
            16,
            12,
            AppColors.grey,
          ),
          suffixIcon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.grey,
            size: 20,
          ),
          onSuffixIconTap: () {
            obscureNotifier.value = !obscureNotifier.value;
          },
          obscureText: isObscure,
          textInputAction: TextInputAction.done,
          validators: [
            FormBuilderValidators.required(errorText: 'Password is required'),
            FormBuilderValidators.minLength(
              6,
              errorText: 'Password must be at least 6 characters',
            ),
          ],
          onSubmitted: onSubmitted,
          initialValue: initialValue,
          onChanged: onChanged,
          textStyle: textTheme.body,
          hintStyle: textTheme.body,
        );
      },
    );
  }

  static void dispose() {
    for (var notifier in _passwordVisibilityNotifiers.values) {
      notifier.dispose();
    }
    _passwordVisibilityNotifiers.clear();
  }

  // Phone Field
  static Widget phone({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return CustomTextField(
      name: 'phone',
      hintText: 'Phone Number',
      buttonTheme: buttonTheme,
      prefixIcon: AppImages.svgIcon(context, Constants.call, 16, 12),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      validators: [
        FormBuilderValidators.required(errorText: 'Phone number is required'),
        FormBuilderValidators.numeric(
          errorText: 'Please enter valid phone number',
        ),
      ],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
      textStyle: textTheme.body,
      hintStyle: textTheme.body,
    );
  }

  // Name Field
  static Widget name({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    required String name,
    required String hintText,
    String requiredError = 'This field is required',
    String minLengthError = 'Must be at least 2 characters',
    int minLength = 2,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return CustomTextField(
      name: name,
      hintText: hintText,
      buttonTheme: buttonTheme,
      keyboardType: TextInputType.name,
      prefixIcon: AppImages.svgIcon(
        context,
        Constants.profile,
        16,
        12,
        AppColors.black,
      ),
      textInputAction: TextInputAction.next,
      validators: [
        FormBuilderValidators.required(errorText: requiredError),
        FormBuilderValidators.minLength(minLength, errorText: minLengthError),
      ],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
      textStyle: textTheme.body,
      hintStyle: textTheme.body,
    );
  }

  static Widget startTimeDate({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    String hintText = Constants.startDateAndTime,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return CustomTextField(
      name: Constants.startDateAndTime,
      hintText: hintText,
      readOnly: true,
      buttonTheme: buttonTheme,
      suffixIcon: GestureDetector(
        onTap: () async {
          final result = await DateTimePickerUtil.pickDateTime(context);
          if (result != null) {
            onChanged?.call(result);
          }
        },
        child: AppImages.svgIcon(context, Constants.calendar, 16, 12),
      ),
      keyboardType: TextInputType.name,

      textInputAction: TextInputAction.next,
      validators: [
        FormBuilderValidators.required(
          errorText: 'Start Date and Time is required',
        ),
        FormBuilderValidators.minLength(
          2,
          errorText: 'Please select start date',
        ),
      ],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
      textStyle: textTheme.body,
      hintStyle: textTheme.body,
    );
  }

  static Widget endTimeDate({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    String hintText = Constants.endDateAndTime,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return CustomTextField(
      name: Constants.endDateAndTime,
      readOnly: true,
      hintText: hintText,
      buttonTheme: buttonTheme,
      suffixIcon: GestureDetector(
        onTap: () async {
          final result = await DateTimePickerUtil.pickDateTime(context);
          if (result != null) {
            onChanged?.call(result);
          }
        },
        child: AppImages.svgIcon(context, Constants.calendar, 16, 12),
      ),
      keyboardType: TextInputType.name,

      textInputAction: TextInputAction.next,
      validators: [
        FormBuilderValidators.required(
          errorText: 'End Date and Time is required',
        ),
        FormBuilderValidators.minLength(2, errorText: 'Please select end date'),
      ],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
      textStyle: textTheme.body,
      hintStyle: textTheme.body,
    );
  }

  static Widget multiline({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    required String name,
    required String hintText,
    String requiredError = 'This field is required',
    int maxLines = 5,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return CustomTextField(
      name: name,
      hintText: hintText,
      buttonTheme: buttonTheme,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: maxLines,
      validators: [FormBuilderValidators.required(errorText: requiredError)],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
      textStyle: textTheme.body,
      hintStyle: textTheme.body,
    );
  }

  static Widget counter({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    required String name,
    required String hintText,
    int initialCount = 0,
    int minValue = 0,
    VoidCallback? onSubmitted,
    ValueChanged<String?>? onChanged,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    int count = initialCount;

    return StatefulBuilder(
      builder: (context, setState) {
        void increment() {
          setState(() {
            count++;
          });
          onChanged?.call(count.toString());
        }

        void decrement() {
          if (count > minValue) {
            setState(() {
              count--;
            });
            onChanged?.call(count.toString());
          }
        }

        return CustomTextField(
          name: name,
          hintText: hintText,
          buttonTheme: buttonTheme,
          readOnly: true,
          initialValue: count.toString(),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: increment,
                child: Transform.rotate(
                  angle: math.pi / 2, // arrow pointing down
                  child: Padding(
                    padding: EdgeInsets.all(sl<SizeConfig>().rpx(8)),
                    child: AppImages.svgIcon(
                      context,
                      Constants.backArrow,
                      12,
                      12,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: decrement,
                child: Transform.rotate(
                  angle: -math.pi / 2, // arrow pointing up
                  child: Padding(
                    padding: EdgeInsets.all(sl<SizeConfig>().rpx(8)),
                    child: AppImages.svgIcon(
                      context,
                      Constants.backArrow,
                      12,
                      12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          validators: [
            FormBuilderValidators.required(errorText: '$hintText is required'),
            FormBuilderValidators.numeric(errorText: 'Enter valid number'),
          ],
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          textStyle: textTheme.body,
          hintStyle: textTheme.body,
        );
      },
    );
  }

  static Widget custom({
    required String name,
    required String hintText,
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    List<String? Function(String?)>? validators,
    VoidCallback? onSubmitted,
    int? maxLines = 1,
    bool enabled = true,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    return CustomTextField(
      name: name,
      hintText: hintText,
      buttonTheme: buttonTheme,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validators: validators,
      onSubmitted: onSubmitted,
      maxLines: maxLines,
      enabled: enabled,
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }
}
