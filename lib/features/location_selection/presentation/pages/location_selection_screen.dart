import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/location_selection/presentation/widgets/city_list_widget.dart';
import 'package:pingvite/features/location_selection/presentation/widgets/location_selection_header.dart';
import 'package:pingvite/features/location_selection/presentation/widgets/location_selection_form.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/service_locator_dependencies.dart';
import 'package:pingvite/features/location_selection/data/models/location_model.dart';
import 'package:pingvite/features/location_selection/presentation/bloc/location_bloc.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  List<CityModel> citiesList = [];
  LocationSuggestion? _selectedState;

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, false);
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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: isDarkMode ? AppColors.white : AppColors.black,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
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
                'city': state.cityName,
                'state': state.stateName,
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

                  // Location Selection Form
                  LocationSelectionForm(
                    isDarkMode: isDarkMode,
                    onCountrySelected: (_) {},
                    onStateSelected: (state) {
                      setState(() {
                        _selectedState = state;
                        if (_selectedState != null) {
                          // Fetch cities for selected state
                          citiesList = [];
                        }
                      });
                    },
                  ),
                  Gap(sizeConfig.rpx(30)),

                  // Cities Section
                  if (_selectedState != null && citiesList.isEmpty)
                    _buildLoadingCities(context)
                  else if (_selectedState != null && citiesList.isNotEmpty)
                    _buildCitiesSection(context, isDarkMode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCities(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: sizeConfig.rpx(40)),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.blue),
      ),
    );
  }

  Widget _buildCitiesSection(BuildContext context, bool isDarkMode) {
    final sizeConfig = sl<SizeConfig>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cities Header
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(sizeConfig.rpx(8)),
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(sizeConfig.rpx(8)),
              ),
              child: Icon(
                Icons.location_city,
                color: AppColors.blue,
                size: sizeConfig.rpx(20),
              ),
            ),
            Gap(sizeConfig.rpx(10)),
            AppTexts(
              text: 'Select City',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppColors.white : AppColors.black,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        Gap(sizeConfig.rpx(16)),
        CityListWidget(
          cities: citiesList,
          stateName: _selectedState?.name ?? 'Unknown',
          onCitySelected: (cityName) {
            context.read<LocationBloc>().add(
              SelectCityEvent(
                cityName: cityName,
                stateName: _selectedState?.name ?? 'Unknown',
              ),
            );
          },
        ),
      ],
    );
  }
}

// Old methods removed - using new widgets instead
