import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/data/dummy_event_list.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/features/bottom_tabs/events_screen/presentation/widgets/event_card_widget.dart';
import 'package:pingvite/features/bottom_tabs/home_tab/presentation/widgets/current_event_header.dart';

class CurrentEventScreen extends StatefulWidget {
  const CurrentEventScreen({super.key});

  @override
  State<CurrentEventScreen> createState() => _CurrentEventScreenState();
}

class _CurrentEventScreenState extends State<CurrentEventScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        spacing: 30,
        children: [
          CurrentEventHeader(),
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: AppTexts(
              text: Constants.currentEvent,
              style: textTheme.body2.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          EventCardWidget(
            dummyEvents: dummyEvents,
            extraContent: (event) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Accepted + Pending
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Accepted",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 6),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Text(
                              "10",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            "Pending",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 6),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.orange,
                            child: Text(
                              "10",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Example avatars
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(
                      4,
                      (i) => Column(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://i.pravatar.cc/100",
                            ),
                            radius: 24,
                          ),
                          const SizedBox(height: 6),
                          Text("Stave Smith", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
