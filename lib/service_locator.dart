part of 'service_locator_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependecies() async {
  sl.registerLazySingleton<SizeConfig>(() => SizeConfig());
}
