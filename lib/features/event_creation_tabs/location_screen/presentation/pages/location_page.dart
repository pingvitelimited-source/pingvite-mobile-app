import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: AppTexts(text: "Location Page"));
  }
}
