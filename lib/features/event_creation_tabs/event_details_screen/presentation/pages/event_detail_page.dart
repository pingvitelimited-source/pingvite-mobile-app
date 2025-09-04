import 'package:flutter/material.dart';
import 'package:pingvite/features/event_creation_tabs/event_details_screen/presentation/widgets/event_detail_form.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return EventDetailForm();
  }
}
