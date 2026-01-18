import 'package:dartz/dartz.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/features/location_search/domain/repository/location_search_repository.dart';

class SearchStatesUseCase {
  final LocationSearchRepository repository;

  SearchStatesUseCase(this.repository);

  Future<Either<dynamic, List<LocationSuggestion>>> call(
    String query,
    String countryId,
  ) async {
    return await repository.searchStates(query, countryId);
  }
}
