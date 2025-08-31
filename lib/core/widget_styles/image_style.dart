import 'package:flutter/material.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ImageStyle extends StatelessWidget {
  final String imagePath;
  final double? heightPx;
  final double? widthPx;
  final BoxFit fit;
  final Color? color;

  const ImageStyle({
    required this.imagePath,
    this.heightPx,
    this.widthPx,
    this.fit = BoxFit.contain,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: heightPx != null ? sl<SizeConfig>().rpx(heightPx!) : null,
      width: widthPx != null ? sl<SizeConfig>().rpx(widthPx!) : null,
      fit: fit,
      color: color,
    );
  }
}
