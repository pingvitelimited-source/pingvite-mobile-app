import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/shared_widgets/shared_widgets.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/venue_create_form.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';

class CreateVenueScreen extends StatefulWidget {
  const CreateVenueScreen({super.key});

  @override
  State<CreateVenueScreen> createState() => _CreateVenueScreenState();
}

class _CreateVenueScreenState extends State<CreateVenueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar.withBackButton(
        title: Constants.createNewVenue,
        hasNotification: true,
      ),
      body: const VenueCreateForm(),
      bottomNavigationBar: FormBottomButtons.dualAction(
        secondaryText: "Save draft",
        primaryText: "Submit",
        onSecondaryPressed: () {},
        onPrimaryPressed: () {},
      ),
    );
  }
}
