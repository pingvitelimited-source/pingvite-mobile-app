import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/custom_widgets/app_input_decorators.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<String? Function(String?)>? validators;
  final VoidCallback? onSubmitted;
  final AppButtonTheme buttonTheme;
  final int? maxLines;
  final bool enabled;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;
  final bool readOnly;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const CustomTextField({
    super.key,
    required this.name,
    required this.hintText,
    required this.buttonTheme,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validators,
    this.onSubmitted,
    this.maxLines = 1,
    this.enabled = true,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.textStyle,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final isLocked = !enabled || readOnly;

    // Text fields have white background, so text must always be dark
    final inputTextStyle = (textStyle ?? textTheme.body).copyWith(
      color: AppColors.lightPrimaryText,
    );
    final inputHintStyle = (hintStyle ?? textTheme.body).copyWith(
      color: AppColors.lightSecondaryText,
    );

    return FormBuilderTextField(
      name: name,
      readOnly: readOnly,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      enabled: enabled,
      style: inputTextStyle,
      decoration:
          AppInputDecoration.build(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null && onSuffixIconTap != null
                ? GestureDetector(onTap: onSuffixIconTap, child: suffixIcon)
                : suffixIcon,
            buttonTheme: buttonTheme,
            textTheme: textTheme,
          ).copyWith(
            hintStyle: inputHintStyle,
            filled: true,
            fillColor: isLocked
                ? AppColors.grey.withValues(alpha: 0.08) // 🔒 muted background
                : Colors.white,
          ),
      validator: validators != null
          ? FormBuilderValidators.compose(validators!)
          : null,
      onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      onChanged: onChanged,
    );
  }
}
