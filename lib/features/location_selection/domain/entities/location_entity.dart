import 'package:equatable/equatable.dart';

class StateEntity extends Equatable {
  final String id;
  final String name;
  final List<CityEntity> cities;

  const StateEntity({
    required this.id,
    required this.name,
    required this.cities,
  });

  @override
  List<Object?> get props => [id, name, cities];
}

class CityEntity extends Equatable {
  final String id;
  final String name;
  final String stateId;

  const CityEntity({
    required this.id,
    required this.name,
    required this.stateId,
  });

  @override
  List<Object?> get props => [id, name, stateId];
}

class LocationEntity extends Equatable {
  final String selectedCity;
  final String selectedState;
  final DateTime lastUpdated;

  const LocationEntity({
    required this.selectedCity,
    required this.selectedState,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [selectedCity, selectedState, lastUpdated];
}
