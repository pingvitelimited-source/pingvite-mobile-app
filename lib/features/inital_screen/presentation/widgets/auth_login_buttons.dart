import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/inital_screen/presentation/widgets/login_buttons.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AuthLoginButtons extends StatelessWidget {
  final VoidCallback onPhoneLogin;
  final VoidCallback onEmailLogin;

  const AuthLoginButtons({
    super.key,
    required this.onPhoneLogin,
    required this.onEmailLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginButton(
          title: Constants.loginWithPhone,
          icon: AppImages.svgIcon(context, Constants.call, 18, 10),
          onPressed: onPhoneLogin,
        ),
        Gap(sl<SizeConfig>().rpx(25)),
        LoginButton(
          title: Constants.loginWithEmail,
          icon: AppImages.svgIcon(context, Constants.sms, 18, 10),
          onPressed: onEmailLogin,
        ),
      ],
    );
  }
}
