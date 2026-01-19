import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/features/forgot_password/presentation/bloc/reset_password_bloc.dart';

class ResetPasswordForm extends StatefulWidget {
  final AnimationController controller;
  final String type;
  final String value;

  const ResetPasswordForm({
    super.key,
    required this.controller,
    required this.type,
    required this.value,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _handleResetPassword(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).unfocus();

      final formData = _formKey.currentState!.value;
      final newPassword = formData['new_password'] as String;
      final confirmPassword = formData['confirm_password'] as String;

      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match!'),
            backgroundColor: AppColors.red,
          ),
        );
        return;
      }

      context.read<ResetPasswordBloc>().add(
            ResetPasswordSubmitted(
              type: widget.type,
              value: widget.value,
              password: newPassword,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to login screen after success
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.signin,
                (route) => false,
              );
            }
          });
        } else if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: widget.controller,
          curve: Curves.easeOut,
        ),
        axisAlignment: -1,
        child: FormBuilder(
          key: _formKey,
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
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  final isLoading = state is ResetPasswordLoading;

                  return AppButtonFactory.build(
                    width: double.infinity,
                    context: context,
                    type: ButtonType.gradient,
                    title: isLoading
                        ? Constants.pleasewait
                        : Constants.resetPassword,
                    onPressed: isLoading
                        ? () {}
                        : () => _handleResetPassword(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
