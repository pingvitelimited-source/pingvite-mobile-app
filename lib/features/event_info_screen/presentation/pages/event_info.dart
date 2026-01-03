import 'package:flutter/material.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/utils/event_header_info.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/event_info_screen/presentation/widgets/info_details.dart';

class EventInfo extends StatefulWidget {
  final EventCardData? data;
  const EventInfo({super.key, required this.data});

  @override
  State<EventInfo> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfo> {
  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Scaffold(
      backgroundColor: cardTheme.screenBackgroundColor,
      appBar: CustomAppBar.withBackButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.rpx, horizontal: 4.rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventHeaderInfo(data: widget.data),
              InfoDetails(data: widget.data),
            ],
          ),
        ),
      ),
    );
  }
}
