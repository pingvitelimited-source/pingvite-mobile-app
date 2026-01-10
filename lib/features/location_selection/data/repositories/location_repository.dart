import 'package:pingvite/features/location_selection/data/models/location_model.dart';
import 'package:pingvite/features/location_selection/data/datasource/location_dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepository {
  final SharedPreferences sharedPreferences;

  LocationRepository({required this.sharedPreferences});

  static const String _storageKey = 'selected_location';

  Future<List<StateModel>> getAllStates() async {
    // Simulate network delay for realism
    await Future.delayed(const Duration(milliseconds: 300));
    return LocationDummyData.states;
  }

  Future<List<CityModel>> getCitiesByState(String stateId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    final state = LocationDummyData.states.firstWhere(
      (s) => s.id == stateId,
      orElse: () => LocationDummyData.states.first,
    );

    return state.cities;
  }

  Future<void> saveSelectedLocation(String cityName, String stateName) async {
    final location = LocationModel(
      selectedCity: cityName,
      selectedState: stateName,
      lastUpdated: DateTime.now(),
    );

    await sharedPreferences.setString(_storageKey, locationToJson(location));
  }

  Future<bool> isLocationSaved() async {
    final jsonString = sharedPreferences.getString(_storageKey);
    return jsonString != null;
  }

  Future<LocationModel> getSelectedLocation() async {
    final jsonString = sharedPreferences.getString(_storageKey);

    if (jsonString == null) {
      // No saved location - throw exception to indicate first login
      throw Exception(
        'No location saved. First login - show location selection screen',
      );
    }

    // Parse JSON string back to LocationModel
    final json = _parseJsonString(jsonString);
    return LocationModel.fromJson(json);
  }

  String locationToJson(LocationModel location) {
    return '''{"selectedCity":"${location.selectedCity}","selectedState":"${location.selectedState}","lastUpdated":"${location.lastUpdated.toIso8601String()}"}''';
  }

  Map<String, dynamic> _parseJsonString(String jsonString) {
    // Simple JSON parsing to avoid json package dependency issues
    final cityMatch = RegExp(
      r'"selectedCity":"([^"]+)"',
    ).firstMatch(jsonString);
    final stateMatch = RegExp(
      r'"selectedState":"([^"]+)"',
    ).firstMatch(jsonString);
    final timeMatch = RegExp(r'"lastUpdated":"([^"]+)"').firstMatch(jsonString);

    return {
      'selectedCity': cityMatch?.group(1) ?? '',
      'selectedState': stateMatch?.group(1) ?? '',
      'lastUpdated': timeMatch?.group(1) ?? DateTime.now().toIso8601String(),
    };
  }

  // Clear location data (for testing/debugging)
  Future<void> clearLocation() async {
    await sharedPreferences.remove(_storageKey);
  }
}
