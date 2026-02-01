import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/location_selection/presentation/widgets/location_selection_header.dart';
import 'package:pingvite/features/location_selection/presentation/widgets/location_selection_form.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/service_locator_dependencies.dart';
import 'package:pingvite/features/location_selection/presentation/bloc/location_bloc.dart';

class LocationSelectionScreen extends StatefulWidget {
  final bool isFirstTime;

  const LocationSelectionScreen({super.key, this.isFirstTime = false});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  LocationSuggestion? _selectedState;
  LocationSuggestion? _selectedCity;

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: !widget.isFirstTime,
      onPopInvokedWithResult: (didPop, result) {
        // Prevent back navigation only for first-time users
      },
      child: Scaffold(
        backgroundColor: isDarkMode
            ? AppColors.darkBackground
            : AppColors.lightbackground,
        appBar: AppBar(
          backgroundColor: isDarkMode
              ? AppColors.darkBackground
              : AppColors.lightbackground,
          elevation: 0,
          automaticallyImplyLeading: !widget.isFirstTime,
          title: AppTexts(
            text: 'Select Your City',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is CitySelected) {
              Navigator.pop(context, {
                'city': _selectedCity?.name ?? state.cityName,
                'state': _selectedState?.name ?? state.stateName,
              });
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(sizeConfig.rpx(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Beautiful Header Card
                  LocationSelectionHeader(isDarkMode: isDarkMode),
                  Gap(sizeConfig.rpx(30)),

                  // Location Selection Form with Autocomplete for Country, State, City
                  LocationSelectionForm(
                    isDarkMode: isDarkMode,
                    onCountrySelected: (country) {
                      setState(() {
                        // Country selected, state will be enabled
                      });
                    },
                    onStateSelected: (state) {
                      setState(() {
                        _selectedState = state;
                      });
                    },
                    onCitySelected: (city) {
                      setState(() {
                        _selectedCity = city;
                      });
                      // Auto-submit when city is selected
                      if (city != null) {
                        context.read<LocationBloc>().add(
                          SelectCityEvent(
                            cityName: city.name,
                            stateName: _selectedState?.name ?? 'Unknown',
                          ),
                        );
                      }
                    },
                  ),
                  Gap(sizeConfig.rpx(30)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
