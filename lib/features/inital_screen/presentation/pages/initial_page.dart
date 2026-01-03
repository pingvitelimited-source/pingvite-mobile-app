import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/auth_screen_header.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/inital_screen/presentation/widgets/auth_login_buttons.dart';
import 'package:pingvite/features/inital_screen/presentation/widgets/term_and_condition.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(sl<SizeConfig>().rpx(60)),
              AuthScreenHeader(),
              Gap(sl<SizeConfig>().rpx(60)),
              AuthLoginButtons(
                onPhoneLogin: () {
                  Navigator.pushNamed(context, AppRoutes.signin, arguments: 0);
                },
                onEmailLogin: () {
                  Navigator.pushNamed(context, AppRoutes.signin, arguments: 1);
                },
              ),
              Gap(sl<SizeConfig>().rpx(50)),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
                child: AppTexts(
                  text: Constants.signup,
                  style: textTheme.semiBold.copyWith(
                    color: isDarkMode
                        ? AppColors.darkAccentText
                        : AppColors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TermAndCondition(),
    );
  }
}
