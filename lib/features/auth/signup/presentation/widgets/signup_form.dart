import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Padding(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldFactory.name(
              context: context,
              buttonTheme: buttonTheme,
              name: Constants.enterFullName,
              hintText: Constants.enterFullName,
            ),
            Gap(sl<SizeConfig>().rpx(25)),
            TextFieldFactory.email(context: context, buttonTheme: buttonTheme),
            Gap(sl<SizeConfig>().rpx(25)),
            TextFieldFactory.phone(context: context, buttonTheme: buttonTheme),
            Gap(sl<SizeConfig>().rpx(25)),
            TextFieldFactory.password(
              context: context,
              buttonTheme: buttonTheme,
              onSubmitted: () {},
            ),
            Gap(sl<SizeConfig>().rpx(40)),
            AppButtonFactory.build(
              width: double.infinity,
              context: context,
              type: ButtonType.gradient,
              title: Constants.createNewButton,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
