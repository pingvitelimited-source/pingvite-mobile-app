import 'package:equatable/equatable.dart';

class StateModel extends Equatable {
  final String id;
  final String name;
  final List<CityModel> cities;

  const StateModel({
    required this.id,
    required this.name,
    required this.cities,
  });

  @override
  List<Object?> get props => [id, name, cities];
}

class CityModel extends Equatable {
  final String id;
  final String name;
  final String stateId;
  final double latitude;
  final double longitude;

  const CityModel({
    required this.id,
    required this.name,
    required this.stateId,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [id, name, stateId, latitude, longitude];
}

class LocationModel extends Equatable {
  final String selectedCity;
  final String selectedState;
  final DateTime lastUpdated;

  const LocationModel({
    required this.selectedCity,
    required this.selectedState,
    required this.lastUpdated,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      selectedCity: json['selectedCity'] ?? 'Mumbai',
      selectedState: json['selectedState'] ?? 'Maharashtra',
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedCity': selectedCity,
      'selectedState': selectedState,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [selectedCity, selectedState, lastUpdated];
}
