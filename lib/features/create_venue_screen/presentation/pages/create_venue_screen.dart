import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/venue_create_form.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class CreateVenueScreen extends StatefulWidget {
  const CreateVenueScreen({super.key});

  @override
  State<CreateVenueScreen> createState() => _CreateVenueScreenState();
}

class _CreateVenueScreenState extends State<CreateVenueScreen> {
  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Scaffold(
      appBar: const CustomAppBar.withBackButton(
        title: Constants.createNewVenue,
        hasNotification: true,
      ),
      body: VenueCreateForm(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sl<SizeConfig>().rpx(50),
          vertical: sl<SizeConfig>().rpx(30),
        ),
        child: SizedBox(
          width: double.infinity,
          child: AppPrimaryButton(
            title: Constants.addVenue,
            textTheme: textTheme,
            buttonTheme: buttonTheme,
            onPressed: () {},
            gradient: const LinearGradient(
              colors: [AppColors.lightGradient, AppColors.darkGradient],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: sl<SizeConfig>().rpx(30),
              vertical: sl<SizeConfig>().rpx(15),
            ),
            buttonTextColor: AppColors.darkPrimaryText,
            textStyle: textTheme.semiBold.copyWith(
              color: AppColors.darkPrimaryText,
            ),
          ),
        ),
      ),
    );
  }
}
