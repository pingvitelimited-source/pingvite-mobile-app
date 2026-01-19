import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/features/location_search/domain/usecases/search_cities.dart';
import 'package:pingvite/features/location_search/domain/usecases/search_countries.dart';
import 'package:pingvite/features/location_search/domain/usecases/search_states.dart';
import 'package:pingvite/features/location_search/presentation/bloc/location_search_event.dart';
import 'package:pingvite/features/location_search/presentation/bloc/location_search_state.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final SearchCountriesUseCase searchCountriesUseCase;
  final SearchStatesUseCase searchStatesUseCase;
  final SearchCitiesUseCase searchCitiesUseCase;

  LocationSearchBloc({
    required this.searchCountriesUseCase,
    required this.searchStatesUseCase,
    required this.searchCitiesUseCase,
  }) : super(LocationSearchInitial()) {
    on<SearchCountriesEvent>(_onSearchCountries);
    on<SearchStatesEvent>(_onSearchStates);
    on<SearchCitiesEvent>(_onSearchCities);
  }

  Future<void> _onSearchCountries(
    SearchCountriesEvent event,
    Emitter<LocationSearchState> emit,
  ) async {
    emit(LocationSearchLoading());

    final result = await searchCountriesUseCase(event.query);

    result.fold(
      (error) => emit(LocationSearchFailure(error.toString())),
      (countries) => emit(CountriesLoaded(countries)),
    );
  }

  Future<void> _onSearchStates(
    SearchStatesEvent event,
    Emitter<LocationSearchState> emit,
  ) async {
    emit(LocationSearchLoading());

    final result = await searchStatesUseCase(event.query, event.countryId);

    result.fold(
      (error) => emit(LocationSearchFailure(error.toString())),
      (states) => emit(StatesLoaded(states)),
    );
  }

  Future<void> _onSearchCities(
    SearchCitiesEvent event,
    Emitter<LocationSearchState> emit,
  ) async {
    emit(LocationSearchLoading());

    final result = await searchCitiesUseCase(event.query, event.stateId);

    result.fold(
      (error) => emit(LocationSearchFailure(error.toString())),
      (cities) => emit(CitiesLoaded(cities)),
    );
  }
}
