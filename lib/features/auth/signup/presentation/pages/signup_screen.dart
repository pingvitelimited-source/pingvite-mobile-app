import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/auth_screen_header.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:pingvite/features/auth/signup/presentation/widgets/signup_form.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/inital_screen/presentation/widgets/term_and_condition.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignupBloc>(),
      child: Scaffold(
        appBar: CustomAppBar.withBackButton(hasNotification: false),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sl<SizeConfig>().rpx(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(sl<SizeConfig>().rpx(40)),
                AuthScreenHeader(),
                Gap(sl<SizeConfig>().rpx(20)),
                const SignupForm(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: TermAndCondition(),
      ),
    );
  }
}
