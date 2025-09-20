import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double size;

  const CustomFAB({
    super.key,
    required this.onPressed,
    required this.child,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: onPressed,
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.lightGradient, AppColors.darkGradient],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}
