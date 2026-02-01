import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';

class VerifyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const VerifyButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppButtonFactory.build(
      width: double.infinity,
      context: context,
      type: ButtonType.gradient,
      title: 'Verify OTP',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
