import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';

class ResetPasswordForm extends StatelessWidget {
  final AnimationController controller;

  const ResetPasswordForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: controller, curve: Curves.easeOut),
      axisAlignment: -1,
      child: Column(
        children: [
          TextFieldFactory.password(
            context: context,
            buttonTheme: buttonTheme,
            hintText: Constants.enterNewPassword,
            fieldKey: "new_password",
          ),
          const SizedBox(height: 16),
          TextFieldFactory.password(
            context: context,
            buttonTheme: buttonTheme,
            hintText: Constants.reenterNewPassword,
            fieldKey: "confirm_password",
          ),
          const SizedBox(height: 32),
          AppButtonFactory.build(
            width: double.infinity,
            context: context,
            type: ButtonType.gradient,
            title: Constants.resetPassword,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
