import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/custom_widgets/app_input_decorators.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
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

  const CustomTextField({
    super.key,
    required this.name,
    required this.hintText,
    required this.buttonTheme,
    this.prefixIcon,
    this.suffixIcon,
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
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      readOnly: readOnly,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      enabled: enabled,
      decoration: AppInputDecoration.build(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        buttonTheme: buttonTheme,
      ),
      validator: validators != null
          ? FormBuilderValidators.compose(validators!)
          : null,
      onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      onChanged: onChanged,
    );
  }
}
