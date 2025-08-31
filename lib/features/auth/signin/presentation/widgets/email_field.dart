import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_input_decorators.dart';
import 'package:pingvite/core/theme/app_buttom_theme.dart';

class EmailField extends StatelessWidget {
  final AppButtonTheme buttonTheme;
  const EmailField({super.key, required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'email',
      decoration: AppInputDecoration.build(
        hintText: 'Registered email ID',
        prefixIcon: AppImages.svgIcon(context, Constants.email, 16, 12),
        buttonTheme: buttonTheme,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Email is required'),
        FormBuilderValidators.email(errorText: 'Please enter a valid email'),
      ]),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}
