import 'package:flutter/material.dart';

class GradientFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Gradient gradient;
  final Widget child;
  final double size;
  final double elevation;

  const GradientFAB({
    super.key,
    required this.onPressed,
    required this.gradient,
    required this.child,
    this.size = 36,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: CircleBorder(),
        splashColor: Colors.white24,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: gradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
