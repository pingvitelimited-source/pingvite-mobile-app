import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';
import 'package:pingvite/features/location_selection/data/models/location_model.dart';

class CityListWidget extends StatefulWidget {
  final List<CityModel> cities;
  final String stateName;
  final Function(String cityName) onCitySelected;

  const CityListWidget({
    required this.cities,
    required this.stateName,
    required this.onCitySelected,
    super.key,
  });

  @override
  State<CityListWidget> createState() => _CityListWidgetState();
}

class _CityListWidgetState extends State<CityListWidget> {
  final searchController = TextEditingController();
  late List<CityModel> filteredCities;

  @override
  void initState() {
    super.initState();
    filteredCities = widget.cities;
  }

  void _filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCities = widget.cities;
      } else {
        filteredCities = widget.cities
            .where(
              (city) => city.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: sizeConfig.rpx(12)),
          child: TextField(
            controller: searchController,
            onChanged: _filterCities,
            decoration: InputDecoration(
              hintText: 'Search cities...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizeConfig.rpx(10)),
                borderSide: BorderSide(
                  color: AppColors.blue.withValues(alpha: 0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizeConfig.rpx(10)),
                borderSide: BorderSide(
                  color: AppColors.blue.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(sizeConfig.rpx(10)),
                borderSide: const BorderSide(color: AppColors.blue, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: filteredCities.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_off_outlined,
                        size: sizeConfig.rpx(48),
                        color: AppColors.lightSecondaryText,
                      ),
                      SizedBox(height: sizeConfig.rpx(12)),
                      Text(
                        'No cities found',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDarkMode
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    return GestureDetector(
                      onTap: () {
                        widget.onCitySelected(city.name);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.blue.withValues(alpha: 0.15),
                              AppColors.blue.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                            sizeConfig.rpx(14),
                          ),
                          border: Border.all(
                            color: AppColors.blue.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              widget.onCitySelected(city.name);
                            },
                            borderRadius: BorderRadius.circular(
                              sizeConfig.rpx(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: sizeConfig.rpx(32),
                                  color: AppColors.blue,
                                ),
                                SizedBox(height: sizeConfig.rpx(8)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sizeConfig.rpx(8),
                                  ),
                                  child: Text(
                                    city.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
