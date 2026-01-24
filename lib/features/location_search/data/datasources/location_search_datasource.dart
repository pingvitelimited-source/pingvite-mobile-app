import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/location_search/data/models/country_model.dart';
import 'package:pingvite/features/location_search/data/models/location_suggestion_model.dart';
import 'package:pingvite/features/location_search/data/models/state_model.dart';
import 'package:pingvite/service_locator_dependencies.dart';

abstract class LocationSearchDataSource {
  Future<List<LocationSuggestionModel>> searchCountries(String query);
  Future<List<LocationSuggestionModel>> searchStates(
    String query,
    String countryId,
  );
  Future<List<LocationSuggestionModel>> searchCities(
    String query,
    String stateId,
  );
}

class LocationSearchDataSourceImpl implements LocationSearchDataSource {
  @override
  Future<List<LocationSuggestionModel>> searchCountries(String query) async {
    try {
      // Fetch from API
      final response = await sl<DioClient>().get(ApiUrls.countries);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;

        // Convert API response to CountryModel
        final countries = data
            .map((item) => CountryModel.fromJson(item as Map<String, dynamic>))
            .toList();

        // Convert to LocationSuggestionModel for UI layer
        final suggestions = countries
            .map(
              (country) => LocationSuggestionModel(
                id: country.id,
                name: country.name,
                type: 'country',
                code: country.code,
              ),
            )
            .toList();

        // Filter by query if provided
        if (query.isEmpty) {
          return suggestions;
        }

        return suggestions
            .where(
              (country) =>
                  country.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<LocationSuggestionModel>> searchStates(
    String query,
    String countryId,
  ) async {
    try {
      // Fetch from API using country code
      final response = await sl<DioClient>().get(
        ApiUrls.getStateList(countryId),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;

        // Convert API response to StateModel
        final states = data
            .map((item) => StateModel.fromJson(item as Map<String, dynamic>))
            .toList();

        // Convert to LocationSuggestionModel for UI layer
        final suggestions = states
            .map(
              (state) => LocationSuggestionModel(
                id: state.id,
                name: state.name,
                type: 'state',
                code: state.code,
              ),
            )
            .toList();

        // Filter by query if provided
        if (query.isEmpty) {
          return suggestions;
        }

        return suggestions
            .where(
              (state) => state.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<LocationSuggestionModel>> searchCities(
    String query,
    String stateId,
  ) async {
    // For now, return empty list
    return [];
  }
}
