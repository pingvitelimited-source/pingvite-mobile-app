import 'package:flutter/material.dart';
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
        content: Text(content),
        backgroundColor: backgroundColor ?? AppColors.circleColor1,
      ),
    );
}
