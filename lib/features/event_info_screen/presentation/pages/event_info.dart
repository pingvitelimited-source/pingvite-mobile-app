import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/banner_image.dart';
import 'package:pingvite/core/utils/event_title.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/event_info_screen/presentation/widgets/info_details.dart';
import 'package:pingvite/features/event_info_screen/presentation/widgets/info_row.dart';

class EventInfo extends StatefulWidget {
  final EventCardData? data;
  const EventInfo({super.key, required this.data});

  @override
  State<EventInfo> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebackground,
      appBar: CustomAppBar.withBackButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.rpx, horizontal: 4.rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventTitle(widget.data?.title ?? ""),
              Gap(15.gap),
              InfoRow(
                leading: Constants.gradientBall,
                text: "By Religare Finance",
                fontWeight: FontWeight.w700,
              ),
              Gap(15.gap),
              InfoRow(
                leading: Constants.locationIcon,
                text: widget.data?.venue ?? "",
              ),
              Gap(15.gap),
              InfoRow(
                leading: Constants.noteText,
                text: widget.data?.dateTime ?? "",
              ),
              Gap(25.gap),
              BannerImage(),
              Gap(35.gap),
              InfoDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
