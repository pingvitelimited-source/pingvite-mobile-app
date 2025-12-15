import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';

class ContactInputSwitcher extends StatelessWidget {
  final bool isPhone;
  final bool isVerified;
  final AppButtonTheme buttonTheme;
  final String? emailValue;
  final String? phoneValue;
  final ValueChanged<String?> onEmailChanged;
  final ValueChanged<String?> onPhoneChanged;
  final Widget? verifiedIcon;

  const ContactInputSwitcher({
    super.key,
    required this.isPhone,
    required this.isVerified,
    required this.buttonTheme,
    this.emailValue,
    this.phoneValue,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    this.verifiedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: isPhone
          ? KeyedSubtree(
              key: const ValueKey('phone_field'),
              child: TextFieldFactory.phone(
                context: context,
                buttonTheme: buttonTheme,
                initialValue: phoneValue,
                isEnabled: !isVerified,
                suffixIcon: isVerified ? verifiedIcon : null,
                onChanged: onPhoneChanged,
              ),
            )
          : KeyedSubtree(
              key: const ValueKey('email_field'),
              child: TextFieldFactory.email(
                context: context,
                buttonTheme: buttonTheme,
                initialValue: emailValue,
                isEnabled: !isVerified,
                suffixIcon: isVerified ? verifiedIcon : null,
                onChanged: onEmailChanged,
              ),
            ),
    );
  }
}
