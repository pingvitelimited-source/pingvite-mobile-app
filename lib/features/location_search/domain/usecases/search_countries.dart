import 'package:dartz/dartz.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/features/location_search/domain/repository/location_search_repository.dart';

class SearchCountriesUseCase {
  final LocationSearchRepository repository;

  SearchCountriesUseCase(this.repository);

  Future<Either<dynamic, List<LocationSuggestion>>> call(String query) async {
    return await repository.searchCountries(query);
  }
}
