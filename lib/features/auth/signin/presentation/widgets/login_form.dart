import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/session_manager.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class LoginForm extends StatefulWidget {
  final int? authType;
  const LoginForm({super.key, this.authType});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).unfocus();
      setState(() => isLoading = true);

      final formData = _formKey.currentState!.value;
      final email = formData['email_field'] as String?;

      try {
        await Future.delayed(const Duration(seconds: 2));

        // Save session for persistent login
        await SessionManager.saveSession(email: email);

        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Padding(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.authType == 0
                ? TextFieldFactory.phone(
                    context: context,
                    buttonTheme: buttonTheme,
                  )
                : TextFieldFactory.email(
                    context: context,
                    buttonTheme: buttonTheme,
                  ),
            Gap(sl<SizeConfig>().rpx(25)),
            TextFieldFactory.password(
              context: context,
              buttonTheme: buttonTheme,
              onSubmitted: _handleLogin,
            ),
            Gap(sl<SizeConfig>().rpx(25)),
            AppButtonFactory.build(
              context: context,
              type: ButtonType.simple,
              title: Constants.loginButton,
              onPressed: _handleLogin,
              backgroundColor: AppColors.blue,
              textColor: AppColors.white,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
