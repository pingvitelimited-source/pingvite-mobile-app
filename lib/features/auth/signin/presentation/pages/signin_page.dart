import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/permissions.dart';
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
  bool permissionsHandled = false;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermissions();
  }

  Future<void> _checkAndRequestPermissions() async {
    // Wait a bit for the page to load
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    // Check location permission first
    final hasLocationBeenAsked = await PermissionManager.hasLocationBeenAsked();
    if (!hasLocationBeenAsked && mounted) {
      await _showLocationPermissionDialog();
    }

    // Then check camera permission
    if (!mounted) return;
    final hasCameraBeenAsked = await PermissionManager.hasCameraBeenAsked();
    if (!hasCameraBeenAsked && mounted) {
      await _showCameraPermissionDialog();
    }
  }

  Future<void> _showLocationPermissionDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LocationPermissionDialog(
        onComplete: () {
          // Location permission handled
        },
      ),
    );
  }

  Future<void> _showCameraPermissionDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CameraPermissionDialog(
        onComplete: () {
          // Camera permission handled
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(32)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(sl<SizeConfig>().rpx(60)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppImages.image(Constants.appLogo, 74.71, 74.71),
                        Gap(sl<SizeConfig>().rpx(8)),
                        AppTexts(
                          text: Constants.loginHeaderText,
                          style: textTheme.heading.copyWith(
                            fontSize: sl<SizeConfig>().rpx(32),
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightPrimaryText,
                          ),
                        ),
                      ],
                    ),
                    Gap(sl<SizeConfig>().rpx(2)),
                    Padding(
                      padding: EdgeInsets.only(left: sl<SizeConfig>().rpx(83)),
                      child: AppTexts(
                        text: Constants.loginHeaderSubText,
                        style: textTheme.body.copyWith(
                          fontSize: sl<SizeConfig>().rpx(13),
                          color: AppColors.lightSecondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(sl<SizeConfig>().rpx(50)),
                const LoginForm(),
                Gap(sl<SizeConfig>().rpx(16)),
                GestureDetector(
                  onTap: () {},
                  child: AppTexts(
                    text: Constants.forgotPasswordText,
                    style: textTheme.body.copyWith(
                      color: AppColors.blue,
                      fontSize: sl<SizeConfig>().rpx(14),
                    ),
                  ),
                ),
                Gap(sl<SizeConfig>().rpx(120)),
                AppPrimaryButton(
                  title: Constants.createNewButton,
                  isLoading: _isLoading,
                  textTheme: textTheme,
                  buttonTheme: buttonTheme,
                  onPressed: () {},
                  gradient: const LinearGradient(
                    colors: [AppColors.lightGradient, AppColors.darkGradient],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  backgroundColor: Colors.transparent,
                  buttonTextColor: AppColors.white,
                  textFontSize: sl<SizeConfig>().rpx(16),
                  borderColor: Colors.transparent,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: sl<SizeConfig>().rpx(40),
                    vertical: sl<SizeConfig>().rpx(14),
                  ),
                  textStyle: textTheme.semiBold.copyWith(
                    color: AppColors.white,
                    fontSize: sl<SizeConfig>().rpx(16),
                  ),
                ),
                Gap(sl<SizeConfig>().rpx(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
