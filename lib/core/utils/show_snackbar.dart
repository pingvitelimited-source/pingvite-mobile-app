import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';

void showSnackBar(
  BuildContext context,
  String content, {
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: AppTexts(text: content),
        backgroundColor: backgroundColor ?? AppColors.circleColor1,
      ),
    );
}
