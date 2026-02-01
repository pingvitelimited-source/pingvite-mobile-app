import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/shared_widgets/shared_widgets.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/create_venue_screen/presentation/widgets/seating_card.dart';
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
  final _animatedListKey = GlobalKey<AnimatedListState>();
  File? _selectedImage;

  // Location selections
  LocationSuggestion? _selectedCountry;
  LocationSuggestion? _selectedState;
  bool _isStateSelected = false;

  // Seating entries
  final List<int> _seatingEntries = [0]; // Start with one entry
  int _nextId = 1;

  // Validation errors
  String? _countryError;
  String? _stateError;

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
              hintText: Constants.venueName,
              validators: [
                FormBuilderValidators.required(
                  errorText: Constants.venueNameRequired,
                ),
              ],
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Venue Description
            TextFieldFactory.multiline(
              context: context,
              buttonTheme: buttonTheme,
              name: "venueDescription",
              hintText: Constants.venueDescription,
              requiredError: Constants.descriptionRequired,
              maxLines: 3,
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Address Line 1
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "addressLine1",
              hintText: Constants.addressLine1,
              validators: [
                FormBuilderValidators.required(
                  errorText: Constants.addressRequired,
                ),
              ],
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Address Line 2
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "addressLine2",
              hintText: Constants.addressLine2,
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Country Autocomplete
            LocationAutocompleteField(
              name: "country",
              hintText: Constants.selectCountry,
              locationType: 'country',
              errorText: _countryError,
              onSelected: (country) {
                setState(() {
                  _selectedCountry = country;
                  _selectedState = null;
                  _isStateSelected = false;
                  _countryError = null;
                  _stateError = null;
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // State Autocomplete
            LocationAutocompleteField(
              name: "state",
              hintText: Constants.selectState,
              locationType: 'state',
              parentId:
                  _selectedCountry?.code, // Pass country code instead of ID
              enabled: _selectedCountry != null,
              errorText: _stateError,
              onSelected: (state) {
                setState(() {
                  _selectedState = state;
                  _isStateSelected = true;
                  _stateError = null;
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // City Autocomplete
            LocationAutocompleteField(
              name: "city",
              hintText: Constants.selectCity,
              locationType: 'city',
              parentId: _selectedState?.id,
              enabled: _isStateSelected,
              onSelected: (city) {
                setState(() {
                  _isStateSelected = true;
                });
              },
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Pincode
            TextFieldFactory.custom(
              context: context,
              buttonTheme: buttonTheme,
              name: "pincode",
              hintText: Constants.pincode,
              validators: [
                FormBuilderValidators.required(
                  errorText: Constants.pincodeRequired,
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
              hintText: Constants.landmark,
            ),
            SizedBox(height: sl<SizeConfig>().rpx(16)),

            // Seating/Tickets Cards with AnimatedList
            AnimatedList(
              key: _animatedListKey,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              initialItemCount: _seatingEntries.length,
              itemBuilder: (context, index, animation) {
                if (index >= _seatingEntries.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: sl<SizeConfig>().rpx(16)),
                  child: _buildSeatingCard(
                    index,
                    animation,
                    _seatingEntries[index],
                  ),
                );
              },
            ),

            // Add More Link
            GestureDetector(
              onTap: _addSeatingCard,
              child: AppTexts(
                text: Constants.addMore,
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

  void _addSeatingCard() {
    final newId = _nextId++;
    _seatingEntries.add(newId);
    _animatedListKey.currentState?.insertItem(
      _seatingEntries.length - 1,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _deleteSeatingCard(int index) {
    final removedItem = _seatingEntries[index];
    _seatingEntries.removeAt(index);
    _animatedListKey.currentState?.removeItem(
      index,
      (context, animation) => _buildSeatingCard(index, animation, removedItem),
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildSeatingCard(int index, Animation<double> animation, int id) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return SeatingCard(
      key: ValueKey(id),
      index: index,
      buttonTheme: buttonTheme,
      showDelete: _seatingEntries.length > 1,
      onDelete: () => _deleteSeatingCard(index),
      animation: animation,
    );
  }
}
