import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: AppButtonFactory.build(
        context: context,
        type: ButtonType.withPrefixIcon,
        title: title,
        onPressed: onPressed,
        prefixIcon: icon,
      ),
    );
  }
}
