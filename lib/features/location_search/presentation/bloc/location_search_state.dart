import 'package:equatable/equatable.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';

abstract class LocationSearchState extends Equatable {
  const LocationSearchState();

  @override
  List<Object?> get props => [];
}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchLoading extends LocationSearchState {}

class CountriesLoaded extends LocationSearchState {
  final List<LocationSuggestion> countries;

  const CountriesLoaded(this.countries);

  @override
  List<Object?> get props => [countries];
}

class StatesLoaded extends LocationSearchState {
  final List<LocationSuggestion> states;

  const StatesLoaded(this.states);

  @override
  List<Object?> get props => [states];
}

class CitiesLoaded extends LocationSearchState {
  final List<LocationSuggestion> cities;

  const CitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class LocationSearchFailure extends LocationSearchState {
  final String error;

  const LocationSearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LocationSelected extends LocationSearchState {
  final LocationSuggestion? selectedCountry;
  final LocationSuggestion? selectedState;
  final LocationSuggestion? selectedCity;

  const LocationSelected({
    this.selectedCountry,
    this.selectedState,
    this.selectedCity,
  });

  @override
  List<Object?> get props => [selectedCountry, selectedState, selectedCity];

  LocationSelected copyWith({
    LocationSuggestion? selectedCountry,
    LocationSuggestion? selectedState,
    LocationSuggestion? selectedCity,
    bool clearState = false,
    bool clearCity = false,
  }) {
    return LocationSelected(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedState: clearState ? null : (selectedState ?? this.selectedState),
      selectedCity: clearCity ? null : (selectedCity ?? this.selectedCity),
    );
  }
}
