import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/utils/banner_image.dart';
import 'package:pingvite/core/utils/event_title.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/event_info_screen/presentation/widgets/info_row.dart';

class EventHeaderInfo extends StatelessWidget {
  final EventCardData? data;

  const EventHeaderInfo({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventTitle(data?.title ?? ""),
        Gap(15.gap),
        InfoRow(
          leading: Constants.gradientBall,
          text: "By Religare Finance",
          fontWeight: FontWeight.w700,
          useOriginalIconColor: true,
        ),
        Gap(15.gap),
        InfoRow(leading: Constants.locationIcon, text: data?.venue ?? ""),
        Gap(15.gap),
        InfoRow(leading: Constants.noteText, text: data?.dateTime ?? ""),
        Gap(25.gap),
        BannerImage(),
        Gap(35.gap),
      ],
    );
  }
}
