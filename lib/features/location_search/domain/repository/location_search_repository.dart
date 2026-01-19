import 'package:dartz/dartz.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';

abstract class LocationSearchRepository {
  Future<Either<dynamic, List<LocationSuggestion>>> searchCountries(
    String query,
  );
  Future<Either<dynamic, List<LocationSuggestion>>> searchStates(
    String query,
    String countryId,
  );
  Future<Either<dynamic, List<LocationSuggestion>>> searchCities(
    String query,
    String stateId,
  );
}
