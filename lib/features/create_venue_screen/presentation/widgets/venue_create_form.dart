import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/custom_dropdown.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/shared_widgets/shared_widgets.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/features/location_search/presentation/widgets/location_autocomplete_field.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class VenueCreateForm extends StatefulWidget {
  const VenueCreateForm({super.key});

  @override
  State<VenueCreateForm> createState() => _VenueCreateFormState();
}

class _VenueCreateFormState extends State<VenueCreateForm> {
  final _venueformKey = GlobalKey<FormBuilderState>();
  File? _selectedImage;

  // Location selections
  LocationSuggestion? _selectedCountry;
  LocationSuggestion? _selectedState;

  // Validation errors
  String? _countryError;
  String? _stateError;
  String? _cityError;

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
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
      child: FormBuilder(
        key: _venueformKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Venue Name
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "venueName",
              hintText: "Venue Name",
              validators: [
                FormBuilderValidators.required(
                  errorText: "Venue name is required",
                ),
              ],
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Venue Description
            TextFieldFactory.multiline(
              context: context,
              buttonTheme: buttonTheme,
              name: "venueDescription",
              hintText: "Venue Description",
              requiredError: "Description is required",
              maxLines: 3,
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Address Line 1
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "addressLine1",
              hintText: "Address Line 1",
              validators: [
                FormBuilderValidators.required(
                  errorText: "Address is required",
                ),
              ],
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Address Line 2
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "addressLine2",
              hintText: "Address Line 2",
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Country Autocomplete
            LocationAutocompleteField(
              name: "country",
              hintText: "Country",
              locationType: 'country',
              errorText: _countryError,
              onSelected: (country) {
                setState(() {
                  _selectedCountry = country;
                  _selectedState = null;
                  _countryError = null;
                  _stateError = null;
                  _cityError = null;
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // State Autocomplete
            LocationAutocompleteField(
              name: "state",
              hintText: "State",
              locationType: 'state',
              parentId: _selectedCountry?.id,
              enabled: _selectedCountry != null,
              errorText: _stateError,
              onSelected: (state) {
                setState(() {
                  _selectedState = state;
                  _stateError = null;
                  _cityError = null;
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // City Autocomplete
            LocationAutocompleteField(
              name: "city",
              hintText: "City",
              locationType: 'city',
              parentId: _selectedState?.id,
              enabled: _selectedState != null,
              errorText: _cityError,
              onSelected: (city) {
                setState(() {
                  _cityError = null;
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Pincode
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "pincode",
              hintText: "Pincode",
              validators: [
                FormBuilderValidators.required(
                  errorText: "Pincode is required",
                ),
                FormBuilderValidators.numeric(errorText: "Enter valid pincode"),
                FormBuilderValidators.equalLength(
                  6,
                  errorText: "Pincode must be 6 digits",
                ),
              ],
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Landmark
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "landmark",
              hintText: "Landmark",
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Seating/Tickets Category Dropdown
            CustomDropdown<String>(
              name: "seatingCategory",
              hintText: "Seating / Tickets Category",
              buttonTheme: buttonTheme,
              items: const ["VIP", "General", "Premium", "Economy"],
              onChanged: (val) => debugPrint("Seating Category: $val"),
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // No. of Seats/Tickets Dropdown
            CustomDropdown<String>(
              name: "noOfSeats",
              hintText: "No. of Seats / Tickets",
              buttonTheme: buttonTheme,
              items: const ["50", "100", "200", "500", "1000", "2000+"],
              onChanged: (val) => debugPrint("No of Seats: $val"),
            ),
            SizedBox(height: sl<SizeConfig>().rpx(8)),

            // Add More Link
            GestureDetector(
              onTap: () {},
              child: AppTexts(
                text: "+ Add More",
                style: textTheme.body2.copyWith(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: sl<SizeConfig>().rpx(20)),

            // Upload Image Section
            ImageUploadCard(
              initialImage: _selectedImage,
              onImageSelected: (File? image) {
                setState(() {
                  _selectedImage = image;
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(20)),

            // Tags Section
            TagsSection(
              tags: _selectedTags,
              onTagRemoved: (tag) {
                setState(() {
                  _selectedTags.remove(tag);
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(20)),

            // Location Section
            const LocationSection(),
            SizedBox(height: sl<SizeConfig>().rpx(24)),
          ],
        ),
      ),
    );
  }

  File? getSelectedImage() => _selectedImage;
}
