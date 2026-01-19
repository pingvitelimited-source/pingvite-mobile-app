import 'package:dartz/dartz.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/features/location_search/domain/repository/location_search_repository.dart';

class SearchCitiesUseCase {
  final LocationSearchRepository repository;

  SearchCitiesUseCase(this.repository);

  Future<Either<dynamic, List<LocationSuggestion>>> call(
    String query,
    String stateId,
  ) async {
    return await repository.searchCities(query, stateId);
  }
}
