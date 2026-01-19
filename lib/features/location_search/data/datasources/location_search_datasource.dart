import 'package:pingvite/features/location_search/data/models/location_suggestion_model.dart';

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
  // Dummy data - will be replaced with actual API calls
  static const List<Map<String, String>> _dummyCountries = [
    {'id': '1', 'name': 'India', 'type': 'country'},
    {'id': '2', 'name': 'United States', 'type': 'country'},
    {'id': '3', 'name': 'United Kingdom', 'type': 'country'},
    {'id': '4', 'name': 'Canada', 'type': 'country'},
    {'id': '5', 'name': 'Australia', 'type': 'country'},
  ];

  static const Map<String, List<Map<String, String>>> _dummyStates = {
    '1': [
      // India
      {'id': '1-1', 'name': 'Maharashtra', 'type': 'state'},
      {'id': '1-2', 'name': 'Delhi', 'type': 'state'},
      {'id': '1-3', 'name': 'Karnataka', 'type': 'state'},
      {'id': '1-4', 'name': 'Tamil Nadu', 'type': 'state'},
      {'id': '1-5', 'name': 'West Bengal', 'type': 'state'},
      {'id': '1-6', 'name': 'Telangana', 'type': 'state'},
      {'id': '1-7', 'name': 'Gujarat', 'type': 'state'},
      {'id': '1-8', 'name': 'Rajasthan', 'type': 'state'},
    ],
    '2': [
      // United States
      {'id': '2-1', 'name': 'California', 'type': 'state'},
      {'id': '2-2', 'name': 'Texas', 'type': 'state'},
      {'id': '2-3', 'name': 'New York', 'type': 'state'},
      {'id': '2-4', 'name': 'Florida', 'type': 'state'},
    ],
  };

  static const Map<String, List<Map<String, String>>> _dummyCities = {
    '1-1': [
      // Maharashtra
      {'id': '1-1-1', 'name': 'Mumbai', 'type': 'city'},
      {'id': '1-1-2', 'name': 'Pune', 'type': 'city'},
      {'id': '1-1-3', 'name': 'Nagpur', 'type': 'city'},
      {'id': '1-1-4', 'name': 'Nashik', 'type': 'city'},
    ],
    '1-2': [
      // Delhi
      {'id': '1-2-1', 'name': 'New Delhi', 'type': 'city'},
      {'id': '1-2-2', 'name': 'Delhi Cantonment', 'type': 'city'},
    ],
    '1-3': [
      // Karnataka
      {'id': '1-3-1', 'name': 'Bangalore', 'type': 'city'},
      {'id': '1-3-2', 'name': 'Mysore', 'type': 'city'},
      {'id': '1-3-3', 'name': 'Mangalore', 'type': 'city'},
    ],
    '1-4': [
      // Tamil Nadu
      {'id': '1-4-1', 'name': 'Chennai', 'type': 'city'},
      {'id': '1-4-2', 'name': 'Coimbatore', 'type': 'city'},
      {'id': '1-4-3', 'name': 'Madurai', 'type': 'city'},
    ],
    '1-5': [
      // West Bengal
      {'id': '1-5-1', 'name': 'Kolkata', 'type': 'city'},
      {'id': '1-5-2', 'name': 'Howrah', 'type': 'city'},
    ],
    '1-6': [
      // Telangana
      {'id': '1-6-1', 'name': 'Hyderabad', 'type': 'city'},
      {'id': '1-6-2', 'name': 'Warangal', 'type': 'city'},
    ],
  };

  @override
  Future<List<LocationSuggestionModel>> searchCountries(String query) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) {
      return _dummyCountries
          .map((country) => LocationSuggestionModel.fromJson(country))
          .toList();
    }

    final filtered = _dummyCountries
        .where(
          (country) =>
              country['name']!.toLowerCase().contains(query.toLowerCase()),
        )
        .map((country) => LocationSuggestionModel.fromJson(country))
        .toList();

    return filtered;
  }

  @override
  Future<List<LocationSuggestionModel>> searchStates(
    String query,
    String countryId,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    final states = _dummyStates[countryId] ?? [];

    if (query.isEmpty) {
      return states
          .map((state) => LocationSuggestionModel.fromJson(state))
          .toList();
    }

    final filtered = states
        .where(
          (state) => state['name']!.toLowerCase().contains(query.toLowerCase()),
        )
        .map((state) => LocationSuggestionModel.fromJson(state))
        .toList();

    return filtered;
  }

  @override
  Future<List<LocationSuggestionModel>> searchCities(
    String query,
    String stateId,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));

    final cities = _dummyCities[stateId] ?? [];

    if (query.isEmpty) {
      return cities
          .map((city) => LocationSuggestionModel.fromJson(city))
          .toList();
    }

    final filtered = cities
        .where(
          (city) => city['name']!.toLowerCase().contains(query.toLowerCase()),
        )
        .map((city) => LocationSuggestionModel.fromJson(city))
        .toList();

    return filtered;
  }
}
