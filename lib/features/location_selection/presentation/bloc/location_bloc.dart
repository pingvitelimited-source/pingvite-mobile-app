import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pingvite/features/location_selection/data/models/location_model.dart';
import 'package:pingvite/features/location_selection/data/repositories/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc({required this.locationRepository})
    : super(const LocationInitial()) {
    on<FetchStatesEvent>(_onFetchStates);
    on<SelectStateEvent>(_onSelectState);
    on<SelectCityEvent>(_onSelectCity);
    on<LoadCurrentLocationEvent>(_onLoadCurrentLocation);
  }

  Future<void> _onFetchStates(
    FetchStatesEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());
    try {
      final states = await locationRepository.getAllStates();
      emit(LocationStatesLoaded(states: states));
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }

  Future<void> _onSelectState(
    SelectStateEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      final cities = await locationRepository.getCitiesByState(event.stateId);
      emit(
        StateSelected(
          stateId: event.stateId,
          stateName: event.stateName,
          cities: cities,
        ),
      );
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }

  Future<void> _onSelectCity(
    SelectCityEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      await locationRepository.saveSelectedLocation(
        event.cityName,
        event.stateName,
      );
      emit(CitySelected(cityName: event.cityName, stateName: event.stateName));
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }

  Future<void> _onLoadCurrentLocation(
    LoadCurrentLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    try {
      final location = await locationRepository.getSelectedLocation();
      emit(
        LocationLoaded(
          cityName: location.selectedCity,
          stateName: location.selectedState,
        ),
      );
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }
}
