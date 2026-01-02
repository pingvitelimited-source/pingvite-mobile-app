import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventTextFieldsSection extends StatelessWidget {
  const EventTextFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return Column(
      children: [
        // Event Name
        _EventNameField(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Event Description
        _EventDescriptionField(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Event Start Date and Time
        _EventStartDateField(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Event End Date and Time
        _EventEndDateField(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Listing Promo Date and Time
        _ListingPromoDateField(buttonTheme: buttonTheme),
        Gap(sl<SizeConfig>().rpx(20)),

        // Listing Expiry Date and Time
        _ListingExpiryDateField(buttonTheme: buttonTheme),
      ],
    );
  }
}

class _EventNameField extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _EventNameField({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return TextFieldFactory.custom(
      context: context,
      buttonTheme: buttonTheme,
      name: "eventName",
      hintText: "Event name",
      validators: [
        FormBuilderValidators.required(
          errorText: "Event name is required",
        ),
      ],
    );
  }
}

class _EventDescriptionField extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _EventDescriptionField({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return TextFieldFactory.multiline(
      context: context,
      buttonTheme: buttonTheme,
      name: "eventDescription",
      hintText: "Event description",
      maxLines: 4,
      requiredError: "Event description is required",
    );
  }
}

class _EventStartDateField extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _EventStartDateField({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return TextFieldFactory.startTimeDate(
      context: context,
      buttonTheme: buttonTheme,
      hintText: "Event Start date and Time",
      onChanged: (val) => debugPrint("Start DateTime: $val"),
    );
  }
}

class _EventEndDateField extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _EventEndDateField({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return TextFieldFactory.endTimeDate(
      context: context,
      buttonTheme: buttonTheme,
      hintText: "Event End date and Time",
      onChanged: (val) => debugPrint("End DateTime: $val"),
    );
  }
}

class _ListingPromoDateField extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _ListingPromoDateField({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return TextFieldFactory.startTimeDate(
      context: context,
      buttonTheme: buttonTheme,
      hintText: "Listing Promo date and Time",
      onChanged: (val) => debugPrint("Promo DateTime: $val"),
    );
  }
}

class _ListingExpiryDateField extends StatelessWidget {
  final AppButtonTheme buttonTheme;

  const _ListingExpiryDateField({required this.buttonTheme});

  @override
  Widget build(BuildContext context) {
    return TextFieldFactory.endTimeDate(
      context: context,
      buttonTheme: buttonTheme,
      hintText: "Listing Expiry End date and Time",
      onChanged: (val) => debugPrint("Expiry DateTime: $val"),
    );
  }
}
