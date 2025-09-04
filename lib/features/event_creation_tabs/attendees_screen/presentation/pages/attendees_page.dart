import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/event_creation_tabs/attendees_screen/presentation/widgets/attendees_haeder.dart';
import 'package:pingvite/features/event_creation_tabs/attendees_screen/presentation/widgets/attendees_tile.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AttendeesPage extends StatefulWidget {
  const AttendeesPage({super.key});

  @override
  State<AttendeesPage> createState() => _AttendeesPageState();
}

class _AttendeesPageState extends State<AttendeesPage> {
  final List<Map<String, String>> attendees = List.generate(10, (index) {
    return {
      "name": "Stave Smith",
      "email": "stavesmith@gmail.com",
      "tag": "Friend",
      "image": Constants.sample,
    };
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sl<SizeConfig>().rpx(15),
        vertical: sl<SizeConfig>().rpx(20),
      ),
      child: Column(
        children: [
          AttendeesHeader(total: attendees.length),
          SizedBox(height: sl<SizeConfig>().rpx(20)),
          Expanded(
            child: ListView.builder(
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                return AttendeeTile(attendee: attendees[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
