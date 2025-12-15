import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/build_toggle.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/contact_input_switcher.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/reset_password_form.dart';
import 'package:pingvite/features/forgot_password/presentation/widgets/verified_icon.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  bool isPhone = false;
  bool loading = false;
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

  void onConfirm() async {
    if (_revealController.isAnimating || _revealController.isCompleted) {
      return;
    }

    setState(() => loading = true);

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      loading = false;
      _isVerified = true;
    });
    _revealController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Scaffold(
      appBar: CustomAppBar.withBackButton(hasNotification: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(sl<SizeConfig>().rpx(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts(text: Constants.resetPassword, style: textTheme.heading),
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
              AppButtonFactory.build(
                width: double.infinity,
                context: context,
                type: ButtonType.simple,
                title: _isVerified
                    ? Constants.verified
                    : (loading ? Constants.pleasewait : Constants.confirm),
                onPressed: () {
                  _isVerified || loading ? null : onConfirm();
                },
                backgroundColor: _isVerified
                    ? AppColors.grey.withValues(alpha: 0.4)
                    : AppColors.blue,
                textColor: AppColors.white,
                borderColor: Colors.transparent,
              ),
              Gap(sl<SizeConfig>().rpx(40)),
              ResetPasswordForm(controller: _revealController),
            ],
          ),
        ),
      ),
    );
  }
}
