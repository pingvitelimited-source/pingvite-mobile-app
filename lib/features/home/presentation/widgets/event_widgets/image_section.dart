import 'package:flutter/material.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class ImageSection extends StatelessWidget {
  final EventCardData data;
  const ImageSection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.rpx,
      width: double.infinity,
      child: Image.asset(data.image, fit: BoxFit.cover),
    );
  }
}
