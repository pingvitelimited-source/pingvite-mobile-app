import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/build_image_upload_card.dart';
import 'package:pingvite/features/event_creation_tabs/event_details_screen/presentation/widgets/event_dropdowns_section.dart';
import 'package:pingvite/features/event_creation_tabs/event_details_screen/presentation/widgets/event_location_section.dart';
import 'package:pingvite/features/event_creation_tabs/event_details_screen/presentation/widgets/event_tags_section.dart';
import 'package:pingvite/features/event_creation_tabs/event_details_screen/presentation/widgets/event_text_fields_section.dart';
import 'package:pingvite/features/event_creation_tabs/event_details_screen/presentation/widgets/event_toggle_section.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventDetailForm extends StatefulWidget {
  const EventDetailForm({super.key});

  @override
  State<EventDetailForm> createState() => _EventDetailFormState();
}

class _EventDetailFormState extends State<EventDetailForm> {
  final _eventDetailsformKey = GlobalKey<FormBuilderState>();
  File? _selectedImage;

  // Toggle states
  bool _eventLive = true;
  bool _promotion = true;
  bool _registration = true;
  bool _ticketing = true;
  bool _rsvp = true;

  // Selected tags
  final List<String> _selectedTags = [
    'Business',
    'Finance',
    'Mumbai',
    'Delhi',
    'Government',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
      child: FormBuilder(
        key: _eventDetailsformKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Fields Section (Name, Description, Dates)
            const EventTextFieldsSection(),
            Gap(sl<SizeConfig>().rpx(20)),

            // Dropdowns Section (Type, Category, Venue, etc.)
            const EventDropdownsSection(),
            Gap(sl<SizeConfig>().rpx(24)),

            // Toggle Switches Section
            EventToggleSection(
              eventLive: _eventLive,
              promotion: _promotion,
              registration: _registration,
              ticketing: _ticketing,
              rsvp: _rsvp,
              onEventLiveChanged: (val) => setState(() => _eventLive = val),
              onPromotionChanged: (val) => setState(() => _promotion = val),
              onRegistrationChanged: (val) =>
                  setState(() => _registration = val),
              onTicketingChanged: (val) => setState(() => _ticketing = val),
              onRsvpChanged: (val) => setState(() => _rsvp = val),
            ),
            Gap(sl<SizeConfig>().rpx(24)),

            // Upload Image Section
            BuildImageUploadCard(
              textTheme: textTheme,
              initialImage: _selectedImage,
              onImageSelected: (image) {
                setState(() => _selectedImage = image);
              },
            ),
            Gap(sl<SizeConfig>().rpx(24)),

            // Tags Section
            EventTagsSection(selectedTags: _selectedTags),
            Gap(sl<SizeConfig>().rpx(24)),

            // Location Section
            const EventLocationSection(),
            Gap(sl<SizeConfig>().rpx(32)),
          ],
        ),
      ),
    );
  }
}
