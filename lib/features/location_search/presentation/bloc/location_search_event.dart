import 'package:equatable/equatable.dart';

abstract class LocationSearchEvent extends Equatable {
  const LocationSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchCountriesEvent extends LocationSearchEvent {
  final String query;

  const SearchCountriesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchStatesEvent extends LocationSearchEvent {
  final String query;
  final String countryId;

  const SearchStatesEvent({required this.query, required this.countryId});

  @override
  List<Object?> get props => [query, countryId];
}

class SearchCitiesEvent extends LocationSearchEvent {
  final String query;
  final String stateId;

  const SearchCitiesEvent({required this.query, required this.stateId});

  @override
  List<Object?> get props => [query, stateId];
}
