import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/shared_widgets/shared_widgets.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBottomButtons.dualAction(
      secondaryText: Constants.saveAsDraft,
      primaryText: Constants.continueButton,
      onSecondaryPressed: () {
        Navigator.pushNamed(context, AppRoutes.createEvent);
      },
      onPrimaryPressed: () {
        Navigator.pushNamed(context, AppRoutes.createEvent);
      },
    );
  }
}
