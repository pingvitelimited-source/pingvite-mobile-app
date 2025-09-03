import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/auth/signin/presentation/widgets/login_form.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImages.image(Constants.appLogo, 63, 242),
                Gap(sl<SizeConfig>().rpx(20)),
                AppTexts(
                  text: Constants.loginHeaderText,
                  style: textTheme.heading,
                ),
                Gap(sl<SizeConfig>().rpx(10)),
                AppTexts(
                  text: Constants.loginHeaderSubText,
                  style: textTheme.subheading,
                ),
                Gap(sl<SizeConfig>().rpx(30)),
                const LoginForm(),
                Gap(sl<SizeConfig>().rpx(40)),
                AppTexts(
                  text: Constants.forgotPasswordText,
                  style: textTheme.subheading,
                ),
                Gap(sl<SizeConfig>().rpx(50)),
                AppPrimaryButton(
                  title: Constants.createNewButton,
                  isLoading: _isLoading,
                  textTheme: textTheme,
                  buttonTheme: buttonTheme,
                  onPressed: () {},
                  backgroundColor: AppColors.lightbackground,
                  buttonTextColor: AppColors.lightPrimaryText,
                  textFontSize: sl<SizeConfig>().rpx(12),
                  borderColor: AppColors.lightPrimaryText,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: sl<SizeConfig>().rpx(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImages.svgIcon(context, Constants.indianFlag, 20, 20),
            SizedBox(width: 10),
            AppTexts(text: Constants.madeInIndia, style: textTheme.accent),
          ],
        ),
      ),
    );
  }
}
