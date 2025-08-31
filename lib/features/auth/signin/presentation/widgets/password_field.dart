import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_input_decorators.dart';
import 'package:pingvite/core/theme/app_buttom_theme.dart';

class PasswordField extends StatelessWidget {
  final AppButtonTheme buttonTheme;
  final VoidCallback onSubmit;
  const PasswordField({
    super.key,
    required this.buttonTheme,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      obscureText: true,
      decoration: AppInputDecoration.build(
        hintText: 'Password',
        prefixIcon: AppImages.svgIcon(context, Constants.password, 16, 12),
        buttonTheme: buttonTheme,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Password is required'),
        FormBuilderValidators.minLength(
          6,
          errorText: 'Password must be at least 6 characters',
        ),
      ]),
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => onSubmit(),
    );
  }
}
