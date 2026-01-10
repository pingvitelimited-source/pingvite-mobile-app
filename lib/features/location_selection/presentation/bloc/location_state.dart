part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationStatesLoaded extends LocationState {
  final List<StateModel> states;

  const LocationStatesLoaded({required this.states});

  @override
  List<Object?> get props => [states];
}

class StateSelected extends LocationState {
  final String stateId;
  final String stateName;
  final List<CityModel> cities;

  const StateSelected({
    required this.stateId,
    required this.stateName,
    required this.cities,
  });

  @override
  List<Object?> get props => [stateId, stateName, cities];
}

class CitySelected extends LocationState {
  final String cityName;
  final String stateName;

  const CitySelected({required this.cityName, required this.stateName});

  @override
  List<Object?> get props => [cityName, stateName];
}

class LocationLoaded extends LocationState {
  final String cityName;
  final String stateName;

  const LocationLoaded({required this.cityName, required this.stateName});

  @override
  List<Object?> get props => [cityName, stateName];
}

class LocationError extends LocationState {
  final String message;

  const LocationError({required this.message});

  @override
  List<Object?> get props => [message];
}
