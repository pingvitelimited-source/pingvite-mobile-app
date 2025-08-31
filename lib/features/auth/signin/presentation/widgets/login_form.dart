import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/theme/app_buttom_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/auth/signin/presentation/widgets/email_field.dart';
import 'package:pingvite/features/auth/signin/presentation/widgets/password_field.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      //final formData = _formKey.currentState!.value;
      // final email = formData['email'] as String;
      // final password = formData['password'] as String;
      try {
        await Future.delayed(const Duration(seconds: 2)); // simulate API
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return Padding(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmailField(buttonTheme: buttonTheme),
            Gap(sl<SizeConfig>().rpx(25)),
            PasswordField(buttonTheme: buttonTheme, onSubmit: _handleLogin),
            Gap(sl<SizeConfig>().rpx(25)),
            AppPrimaryButton(
              title: Constants.loginButton,
              isLoading: _isLoading,
              textTheme: textTheme,
              buttonTheme: buttonTheme,
              onPressed: _handleLogin,
              gradient: const LinearGradient(
                colors: [AppColors.lightGradient, AppColors.darkGradient],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              buttonTextColor: AppColors.darkPrimaryText,
            ),
          ],
        ),
      ),
    );
  }
}
