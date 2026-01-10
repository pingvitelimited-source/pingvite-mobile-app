part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class FetchStatesEvent extends LocationEvent {
  const FetchStatesEvent();
}

class SelectStateEvent extends LocationEvent {
  final String stateId;
  final String stateName;

  const SelectStateEvent({required this.stateId, required this.stateName});

  @override
  List<Object?> get props => [stateId, stateName];
}

class SelectCityEvent extends LocationEvent {
  final String cityName;
  final String stateName;

  const SelectCityEvent({required this.cityName, required this.stateName});

  @override
  List<Object?> get props => [cityName, stateName];
}

class LoadCurrentLocationEvent extends LocationEvent {
  const LoadCurrentLocationEvent();
}
