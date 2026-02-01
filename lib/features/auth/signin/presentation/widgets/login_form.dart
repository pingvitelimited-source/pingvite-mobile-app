import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/auth/signin/presentation/bloc/signin_bloc.dart';
import 'package:pingvite/features/auth/signin/presentation/bloc/signin_event.dart';
import 'package:pingvite/features/auth/signin/presentation/bloc/signin_state.dart';
import 'package:pingvite/service_locator_dependencies.dart';
import 'package:pingvite/core/utils/session_manager.dart';

class LoginForm extends StatefulWidget {
  final int? authType;
  const LoginForm({super.key, this.authType});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).unfocus();

      final formData = _formKey.currentState!.value;
      final password = formData[Constants.passwordField] as String;

      if (widget.authType == 0) {
        // Login with phone
        final mobile = formData[Constants.phoneField] as String;
        context.read<SigninBloc>().add(
          SigninWithPhoneEvent(mobile: mobile, password: password),
        );
      } else {
        // Login with email
        final email = formData[Constants.emailField] as String;
        context.read<SigninBloc>().add(
          SigninWithEmailEvent(email: email, password: password),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return BlocProvider(
      create: (context) => sl<SigninBloc>(),
      child: BlocConsumer<SigninBloc, SigninState>(
        listener: (context, state) async {
          if (state is SigninSuccess) {
            // Persist login session
            await SessionManager.saveSession();
            if (!context.mounted) return;
            // Clear any existing snackbars before showing success message
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppTexts(text: state.message),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
            // Navigate to home
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is SigninFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppTexts(text: state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is SigninLoading;
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
                    onSubmitted: () => _handleLogin(context),
                  ),
                  Gap(sl<SizeConfig>().rpx(25)),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : AppButtonFactory.build(
                          context: context,
                          type: ButtonType.simple,
                          title: Constants.loginButton,
                          onPressed: () => _handleLogin(context),
                          backgroundColor: AppColors.blue,
                          textColor: AppColors.white,
                          borderColor: Colors.transparent,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
