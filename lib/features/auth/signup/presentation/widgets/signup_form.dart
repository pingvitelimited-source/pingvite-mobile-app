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
import 'package:pingvite/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _handleSignup() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      FocusScope.of(context).unfocus();

      final formData = _formKey.currentState!.value;

      context.read<SignupBloc>().add(
        SignupSubmitted(
          firstName: (formData[Constants.firstName] as String).trim(),
          middleName: (formData[Constants.middleName] as String?)?.trim(),
          lastName: (formData[Constants.lastName] as String).trim(),
          email: (formData[Constants.emailField] as String).trim(),
          mobile: (formData[Constants.phoneField] as String).trim(),
          password: (formData[Constants.passwordField] as String).trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppTexts(text: state.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to login screen
          Navigator.pushReplacementNamed(context, AppRoutes.signin);
        } else if (state is SignupFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppTexts(text: state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldFactory.name(
                context: context,
                buttonTheme: buttonTheme,
                name: Constants.firstName,
                hintText: Constants.firstName,
                requiredError: 'First Name is required',
                minLengthError: 'First Name must be at least 2 characters',
              ),
              Gap(sl<SizeConfig>().rpx(25)),
              TextFieldFactory.optionalName(
                context: context,
                buttonTheme: buttonTheme,
                name: Constants.middleName,
                hintText: Constants.middleName,
              ),
              Gap(sl<SizeConfig>().rpx(25)),
              TextFieldFactory.name(
                context: context,
                buttonTheme: buttonTheme,
                name: Constants.lastName,
                hintText: Constants.lastName,
                requiredError: 'Last Name is required',
                minLengthError: 'Last Name must be at least 2 characters',
              ),
              Gap(sl<SizeConfig>().rpx(25)),
              TextFieldFactory.email(
                context: context,
                buttonTheme: buttonTheme,
              ),
              Gap(sl<SizeConfig>().rpx(25)),
              TextFieldFactory.phone(
                context: context,
                buttonTheme: buttonTheme,
              ),
              Gap(sl<SizeConfig>().rpx(25)),
              TextFieldFactory.password(
                context: context,
                buttonTheme: buttonTheme,
                onSubmitted: _handleSignup,
              ),
              Gap(sl<SizeConfig>().rpx(40)),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return AppButtonFactory.build(
                    width: double.infinity,
                    context: context,
                    type: ButtonType.gradient,
                    title: Constants.createNewButton,
                    isLoading: state is SignupLoading,
                    onPressed: _handleSignup,
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
