import 'package:flutter/material.dart';
import 'package:pingvite/features/bottom_tabs/home_tab/presentation/widgets/current_event_screen.dart';
import 'package:pingvite/features/bottom_tabs/home_tab/presentation/widgets/no_event_screen.dart';

class Hometab extends StatefulWidget {
  const Hometab({super.key});

  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
  bool isEventAvailable = true;
  @override
  Widget build(BuildContext context) {
    return isEventAvailable ? CurrentEventScreen() : NoEventScreen();
  }
}
