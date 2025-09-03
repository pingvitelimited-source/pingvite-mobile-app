import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/custom_dropdown.dart';
import 'package:pingvite/core/custom_widgets/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventDetailForm extends StatefulWidget {
  const EventDetailForm({super.key});

  @override
  State<EventDetailForm> createState() => _EventDetailFormState();
}

class _EventDetailFormState extends State<EventDetailForm> {
  final _eventDetailsformKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Padding(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
      child: FormBuilder(
        key: _eventDetailsformKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldFactory.name(context: context, buttonTheme: buttonTheme),
            Gap(sl<SizeConfig>().rpx(25)),
            TextFieldFactory.startTimeDate(
              context: context,
              buttonTheme: buttonTheme,
              onChanged: (val) {
                debugPrint("Picked DateTime: $val");
              },
            ),
            Gap(sl<SizeConfig>().rpx(25)),
            TextFieldFactory.endTimeDate(
              context: context,
              buttonTheme: buttonTheme,
              onChanged: (val) {
                debugPrint("Picked DateTime: $val");
              },
            ),
            Gap(sl<SizeConfig>().rpx(25)),
            CustomDropdown<String>(
              name: "eventType",
              hintText: "Event Type",
              buttonTheme: buttonTheme,
              items: ["Conference", "Meetup", "Workshop", "Webinar"],
              onChanged: (val) => debugPrint("Selected: $val"),
              validators: [
                FormBuilderValidators.required(
                  errorText: "Event type is required",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
