import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/features/location_search/presentation/widgets/location_autocomplete_field.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class LocationSelectionForm extends StatefulWidget {
  final bool isDarkMode;
  final Function(LocationSuggestion?) onCountrySelected;
  final Function(LocationSuggestion?) onStateSelected;

  const LocationSelectionForm({
    super.key,
    required this.isDarkMode,
    required this.onCountrySelected,
    required this.onStateSelected,
  });

  @override
  State<LocationSelectionForm> createState() => _LocationSelectionFormState();
}

class _LocationSelectionFormState extends State<LocationSelectionForm> {
  LocationSuggestion? _selectedCountry;
  bool _isStateEnabled = false;

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Country Section
        _buildSectionHeader(context, Constants.country, Icons.public),
        Gap(sizeConfig.rpx(12)),
        LocationAutocompleteField(
          name: "country_selection",
          hintText: Constants.selectCountry,
          locationType: 'country',
          onSelected: (country) {
            setState(() {
              _selectedCountry = country;
              _isStateEnabled = country != null;
            });
            widget.onCountrySelected(country);
          },
        ),
        Gap(sizeConfig.rpx(24)),

        // State Section
        _buildSectionHeader(
          context,
          Constants.state,
          Icons.map_outlined,
          isEnabled: _isStateEnabled,
        ),
        Gap(sizeConfig.rpx(12)),
        Opacity(
          opacity: _isStateEnabled ? 1.0 : 0.6,
          child: LocationAutocompleteField(
            name: "state_selection",
            hintText: Constants.selectState,
            locationType: 'state',
            parentId: _selectedCountry?.code,
            enabled: _isStateEnabled,
            onSelected: widget.onStateSelected,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon, {
    bool isEnabled = true,
  }) {
    final sizeConfig = sl<SizeConfig>();

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(sizeConfig.rpx(8)),
          decoration: BoxDecoration(
            color: isEnabled
                ? AppColors.blueLightAlpha15
                : AppColors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(sizeConfig.rpx(8)),
          ),
          child: Icon(
            icon,
            color: isEnabled ? AppColors.blue : AppColors.grey,
            size: sizeConfig.rpx(20),
          ),
        ),
        Gap(sizeConfig.rpx(10)),
        AppTexts(
          text: title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isEnabled
                ? (widget.isDarkMode ? AppColors.white : AppColors.black)
                : AppColors.grey,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
