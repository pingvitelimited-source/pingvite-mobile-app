import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/custom_dropdown.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/build_image_upload_card.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class VenueCreateForm extends StatefulWidget {
  const VenueCreateForm({super.key});

  @override
  State<VenueCreateForm> createState() => _VenueCreateFormState();
}

class _VenueCreateFormState extends State<VenueCreateForm> {
  final _venueformKey = GlobalKey<FormBuilderState>();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Padding(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
      child: FormBuilder(
        key: _venueformKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: sl<SizeConfig>().rpx(25),
            children: [
              TextFieldFactory.name(
                context: context,
                buttonTheme: buttonTheme,
                name: Constants.venueName,
                hintText: Constants.venueName,
                requiredError: Constants.venueNameRequired,
                minLengthError: Constants.venueNameMinChar,
              ),
              CustomDropdown<String>(
                name: "venueType",
                hintText: "Venue Type",
                buttonTheme: buttonTheme,
                items: ["Conference", "Meetup", "Workshop", "Webinar"],
                onChanged: (val) => debugPrint("Selected: $val"),
                validators: [
                  FormBuilderValidators.required(
                    errorText: "Venue type is required",
                  ),
                ],
              ),
              TextFieldFactory.counter(
                context: context,
                buttonTheme: buttonTheme,
                name: "capacity",
                hintText: "Capacity",
                initialCount: 0,
                minValue: 0,
                onChanged: (val) => debugPrint("Capacity: $val"),
              ),
              TextFieldFactory.multiline(
                context: context,
                buttonTheme: buttonTheme,
                name: "venueDescription",
                hintText: "Full Address",
                requiredError: "Description is required",
                maxLines: 4,
              ),
              BuildImageUploadCard(
                textTheme: textTheme,
                initialImage: _selectedImage,
                onImageSelected: (File? image) {
                  setState(() {
                    _selectedImage = image;
                  });
                },
              ),
              // AppCard(
              //   padding: const EdgeInsets.all(16),
              //   borderColor: AppColors.imageUploadCardColor,
              //   margin: EdgeInsets.zero,
              //   borderRadius: 10,
              //   elevation: 0,
              //   backgroundColor: AppColors.imageUploadCardColor,
              //   child: SizedBox(
              //     height: sl<SizeConfig>().rpx(120),
              //     width: double.infinity,
              //     child: GestureDetector(
              //       onTap: () {},
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         spacing: sl<SizeConfig>().rpx(5),
              //         children: [
              //           AppImages.svgIcon(
              //             context,
              //             Constants.imageUpload,
              //             32,
              //             32,
              //           ),
              //           AppTexts(
              //             text: Constants.uploadImage,
              //             style: textTheme.accent.copyWith(
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  File? getSelectedImage() => _selectedImage;
}
