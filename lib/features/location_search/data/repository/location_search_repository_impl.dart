import 'package:dartz/dartz.dart';
import 'package:pingvite/features/location_search/data/datasources/location_search_datasource.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/features/location_search/domain/repository/location_search_repository.dart';

class LocationSearchRepositoryImpl implements LocationSearchRepository {
  final LocationSearchDataSource dataSource;

  LocationSearchRepositoryImpl({required this.dataSource});

  @override
  Future<Either<dynamic, List<LocationSuggestion>>> searchCountries(
    String query,
  ) async {
    try {
      final suggestions = await dataSource.searchCountries(query);
      return Right(suggestions);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<dynamic, List<LocationSuggestion>>> searchStates(
    String query,
    String countryId,
  ) async {
    try {
      final suggestions = await dataSource.searchStates(query, countryId);
      return Right(suggestions);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<dynamic, List<LocationSuggestion>>> searchCities(
    String query,
    String stateId,
  ) async {
    try {
      final suggestions = await dataSource.searchCities(query, stateId);
      return Right(suggestions);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
