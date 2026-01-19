import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/custom_dropdown.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventDropdownsSection extends StatelessWidget {
  const EventDropdownsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return Column(
      children: [
        // Event Type
        _EventTypeDropdown(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Event Category
        _EventCategoryDropdown(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Select Venue
        _VenueDropdown(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Promotion Tag
        _PromotionTagDropdown(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Contacts List
        _ContactsListDropdown(buttonTheme: buttonTheme),
      ],
    );
  }
}

class _EventTypeDropdown extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _EventTypeDropdown({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      name: "eventType",
      hintText: "Event type",
      buttonTheme: buttonTheme,
      items: const ["Conference", "Meetup", "Workshop", "Webinar", "Concert"],
      onChanged: (val) => debugPrint("Event Type: $val"),
      validators: [
        FormBuilderValidators.required(errorText: "Event type is required"),
      ],
    );
  }
}

class _EventCategoryDropdown extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _EventCategoryDropdown({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      name: "eventCategory",
      hintText: "Event Category",
      buttonTheme: buttonTheme,
      items: const ["Business", "Social", "Educational", "Entertainment"],
      onChanged: (val) => debugPrint("Event Category: $val"),
      validators: [
        FormBuilderValidators.required(errorText: "Event category is required"),
      ],
    );
  }
}

class _VenueDropdown extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _VenueDropdown({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      name: "selectVenue",
      hintText: "Select Venue",
      buttonTheme: buttonTheme,
      items: const [
        "MCC Banquet Hall",
        "Palava Cricket Ground",
        "Convention Center",
      ],
      onChanged: (val) => debugPrint("Venue: $val"),
    );
  }
}

class _PromotionTagDropdown extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _PromotionTagDropdown({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      name: "promotionTag",
      hintText: "Promotion Tag",
      buttonTheme: buttonTheme,
      items: const ["Featured", "Trending", "New", "Popular"],
      onChanged: (val) => debugPrint("Promotion Tag: $val"),
    );
  }
}

class _ContactsListDropdown extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _ContactsListDropdown({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      name: "contactsList",
      hintText: "Select Contacts List",
      buttonTheme: buttonTheme,
      items: const ["Friends", "Family", "Work", "VIP Guests"],
      onChanged: (val) => debugPrint("Contacts List: $val"),
    );
  }
}
