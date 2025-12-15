import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/auth_screen_header.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/permissions.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/auth/signin/presentation/widgets/login_form.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SigninPage extends StatefulWidget {
  final int? authType;
  const SigninPage({super.key, this.authType});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
    return Scaffold(
      appBar: CustomAppBar.withBackButton(hasNotification: false),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(sl<SizeConfig>().rpx(70)),
                AuthScreenHeader(),
                Gap(sl<SizeConfig>().rpx(30)),
                LoginForm(authType: widget.authType),
                Gap(sl<SizeConfig>().rpx(40)),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.forgotPassword),
                  child: AppTexts(
                    text: Constants.forgotPasswordText,
                    style: textTheme.semiBold.copyWith(color: AppColors.blue),
                  ),
                ),
                Gap(sl<SizeConfig>().rpx(50)),
                Center(
                  child: AppButtonFactory.build(
                    context: context,
                    type: ButtonType.gradient,
                    title: Constants.createNewButton,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.signup),
                  ),
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
