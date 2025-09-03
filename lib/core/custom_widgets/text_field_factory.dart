import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_textfield.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/date_time_picker_util.dart';

class TextFieldFactory {
  static Widget email({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    return CustomTextField(
      name: 'email',
      hintText: 'Registered email ID',
      buttonTheme: buttonTheme,
      prefixIcon: AppImages.svgIcon(context, Constants.email, 16, 12),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validators: [
        FormBuilderValidators.required(errorText: 'Email is required'),
        FormBuilderValidators.email(errorText: 'Please enter a valid email'),
      ],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }

  // Password Field
  static Widget password({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    return CustomTextField(
      name: 'password',
      hintText: 'Password',
      buttonTheme: buttonTheme,
      prefixIcon: AppImages.svgIcon(context, Constants.password, 16, 12),
      obscureText: true,
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
    );
  }

  // Phone Field
  static Widget phone({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    return CustomTextField(
      name: 'phone',
      hintText: 'Phone Number',
      buttonTheme: buttonTheme,
      prefixIcon: AppImages.svgIcon(context, Constants.email, 16, 12),
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
    );
  }

  // Name Field
  static Widget name({
    required BuildContext context,
    required AppButtonTheme buttonTheme,
    String hintText = Constants.eventName,
    VoidCallback? onSubmitted,
    String? initialValue,
    ValueChanged<String?>? onChanged,
  }) {
    return CustomTextField(
      name: Constants.eventName,
      hintText: hintText,
      buttonTheme: buttonTheme,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validators: [
        FormBuilderValidators.required(errorText: 'Event Name is required'),
        FormBuilderValidators.minLength(
          2,
          errorText: 'Event Name must be at least 2 characters',
        ),
      ],
      onSubmitted: onSubmitted,
      initialValue: initialValue,
      onChanged: onChanged,
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
    );
  }

  // Custom Field - for any other type
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
