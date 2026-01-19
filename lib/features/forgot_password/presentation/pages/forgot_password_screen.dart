import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/forgot_password/presentation/bloc/verify_user_bloc.dart';
import 'package:pingvite/features/forgot_password/presentation/bloc/reset_password_bloc.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/build_toggle.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/contact_input_switcher.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/reset_password_form.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/verified_icon.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<VerifyUserBloc>()),
        BlocProvider(create: (context) => sl<ResetPasswordBloc>()),
      ],
      child: const _ForgotPasswordContent(),
    );
  }
}

class _ForgotPasswordContent extends StatefulWidget {
  const _ForgotPasswordContent();

  @override
  State<_ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<_ForgotPasswordContent>
    with TickerProviderStateMixin {
  bool isPhone = false;
  String? _emailValue;
  String? _phoneValue;
  bool _isVerified = false;

  late AnimationController _revealController;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  void _handleConfirm(BuildContext context) {
    final value = isPhone ? _phoneValue : _emailValue;

    if (value == null || value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isPhone
                ? 'Please enter your phone number'
                : 'Please enter your email',
          ),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    final type = isPhone ? 'mobile' : 'email';

    context.read<VerifyUserBloc>().add(
      VerifyUserSubmitted(type: type, value: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return BlocListener<VerifyUserBloc, VerifyUserState>(
      listener: (context, state) {
        if (state is VerifyUserSuccess) {
          if (state.userExist) {
            setState(() {
              _isVerified = true;
            });
            _revealController.forward();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'User not found. Please check your credentials.',
                ),
                backgroundColor: AppColors.red,
              ),
            );
          }
        } else if (state is VerifyUserFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar.withBackButton(hasNotification: false),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(sl<SizeConfig>().rpx(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(
                  text: Constants.resetPassword,
                  style: textTheme.heading,
                ),
                Gap(sl<SizeConfig>().rpx(8)),
                AppTexts(
                  text: Constants.registedEmailOrPhone,
                  style: textTheme.accent,
                ),
                Gap(sl<SizeConfig>().rpx(32)),
                BuildToggle(
                  isPhone: isPhone,
                  isDisabled: _isVerified,
                  onChanged: (value) {
                    setState(() => isPhone = value);
                  },
                ),
                Gap(sl<SizeConfig>().rpx(20)),
                ContactInputSwitcher(
                  isPhone: isPhone,
                  isVerified: _isVerified,
                  buttonTheme: buttonTheme,
                  emailValue: _emailValue,
                  phoneValue: _phoneValue,
                  verifiedIcon: const VerifiedIcon(),
                  onEmailChanged: (value) {
                    _emailValue = value;
                  },
                  onPhoneChanged: (value) {
                    _phoneValue = value;
                  },
                ),
                Gap(sl<SizeConfig>().rpx(30)),
                BlocBuilder<VerifyUserBloc, VerifyUserState>(
                  builder: (context, state) {
                    final isLoading = state is VerifyUserLoading;

                    return AppButtonFactory.build(
                      width: double.infinity,
                      context: context,
                      type: ButtonType.simple,
                      title: _isVerified
                          ? Constants.verified
                          : (isLoading
                                ? Constants.pleasewait
                                : Constants.confirm),
                      onPressed: (_isVerified || isLoading)
                          ? () {}
                          : () => _handleConfirm(context),
                      backgroundColor: _isVerified
                          ? AppColors.grey.withValues(alpha: 0.4)
                          : AppColors.blue,
                      textColor: AppColors.white,
                      borderColor: Colors.transparent,
                    );
                  },
                ),
                Gap(sl<SizeConfig>().rpx(40)),
                ResetPasswordForm(
                  controller: _revealController,
                  type: isPhone ? 'mobile' : 'email',
                  value: (isPhone ? _phoneValue : _emailValue) ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
