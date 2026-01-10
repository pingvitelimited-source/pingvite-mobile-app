import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';
import 'package:pingvite/features/location_selection/data/models/location_model.dart';
import 'package:pingvite/features/location_selection/presentation/bloc/location_bloc.dart';
import 'package:pingvite/features/location_selection/presentation/widgets/state_dropdown_widget.dart';
import 'package:pingvite/features/location_selection/presentation/widgets/city_list_widget.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? selectedStateId;
  String? selectedStateName;
  List<CityModel> citiesList = [];

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(const FetchStatesEvent());
  }

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
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.blue),
                );
              }

              if (state is LocationError) {
                return Center(
                  child: AppTexts(
                    text: 'Error: ${state.message}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              if (state is LocationStatesLoaded) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(sizeConfig.rpx(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDescriptionCard(context, isDarkMode),
                        Gap(sizeConfig.rpx(30)),
                        _buildStateDropdown(context, state.states, isDarkMode),
                        Gap(sizeConfig.rpx(25)),
                        if (citiesList.isNotEmpty)
                          _buildCitySection(context, isDarkMode),
                      ],
                    ),
                  ),
                );
              }

              if (state is StateSelected) {
                citiesList = state.cities;
                selectedStateId = state.stateId;
                selectedStateName = state.stateName;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(sizeConfig.rpx(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDescriptionCard(context, isDarkMode),
                        Gap(sizeConfig.rpx(30)),
                        _buildStateDropdown(context, [], isDarkMode),
                        Gap(sizeConfig.rpx(25)),
                        _buildCitySection(context, isDarkMode),
                      ],
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(sizeConfig.rpx(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildDescriptionCard(context, isDarkMode)],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context, bool isDarkMode) {
    final sizeConfig = sl<SizeConfig>();
    return Container(
      padding: EdgeInsets.all(sizeConfig.rpx(16)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.blue.withValues(alpha: 0.1),
            AppColors.labelPink.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(sizeConfig.rpx(15)),
        border: Border.all(
          color: AppColors.blue.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.blue,
                size: sizeConfig.rpx(24),
              ),
              Gap(sizeConfig.rpx(12)),
              Expanded(
                child: AppTexts(
                  text: 'Find Events Near You',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? AppColors.darkAccentText
                        : AppColors.lightAccentText,
                  ),
                ),
              ),
            ],
          ),
          Gap(sizeConfig.rpx(12)),
          AppTexts(
            text:
                'Select your state and city to discover amazing events happening in your area.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDarkMode
                  ? AppColors.darkSecondaryText
                  : AppColors.lightSecondaryText,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateDropdown(
    BuildContext context,
    List<StateModel> states,
    bool isDarkMode,
  ) {
    final sizeConfig = sl<SizeConfig>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          text: 'Select State',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.white : AppColors.black,
          ),
        ),
        Gap(sizeConfig.rpx(12)),
        StateDropdownWidget(
          states: states,
          selectedStateName: selectedStateName,
          onStateSelected: (stateId, stateName) {
            setState(() {
              selectedStateId = stateId;
              selectedStateName = stateName;
            });
            context.read<LocationBloc>().add(
              SelectStateEvent(stateId: stateId, stateName: stateName),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCitySection(BuildContext context, bool isDarkMode) {
    final sizeConfig = sl<SizeConfig>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          text: 'Select City',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.white : AppColors.black,
          ),
        ),
        Gap(sizeConfig.rpx(12)),
        CityListWidget(
          cities: citiesList,
          stateName: selectedStateName ?? 'Unknown',
          onCitySelected: (cityName) {
            context.read<LocationBloc>().add(
              SelectCityEvent(
                cityName: cityName,
                stateName: selectedStateName ?? 'Unknown',
              ),
            );
          },
        ),
      ],
    );
  }
}
