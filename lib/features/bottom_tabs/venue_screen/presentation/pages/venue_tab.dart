import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/custom_fab.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/data/model/venue.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/presentation/widgets/venue_card.dart';

class VenueTab extends StatefulWidget {
  const VenueTab({super.key});

  @override
  State<VenueTab> createState() => _VenueTabState();
}

class _VenueTabState extends State<VenueTab> {
  final List<Venue> venues = List.generate(5, (index) {
    return Venue(
      name: "Kolkata Water Park",
      address: "92, Ricky Heights, JackGunj, Kolkata, West Bengal, &00029",
      capacity: "100",
      image: Constants.venueImage, // replace with your asset
    );
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Scaffold(
        body: ListView.builder(
          itemCount: venues.length,
          itemBuilder: (context, index) {
            return VenueCard(venue: venues[index]);
          },
        ),
        floatingActionButton: CustomFAB(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.createVenue);
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
