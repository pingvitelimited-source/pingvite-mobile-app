part of 'service_locator_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependecies() async {
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<SizeConfig>(() => SizeConfig());

  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  // Signup Feature
  _initSignup();

  // Signin Feature
  _initSignin();

  // Location Feature
  _initLocation();
}

void _initSignup() {
  // API Service
  sl.registerLazySingleton<SignupApiService>(() => SignupApiServiceImpl());

  // Repository
  sl.registerLazySingleton<SignupRepository>(() => SignupRepositoryImpl());

  // UseCase
  sl.registerLazySingleton<UserSignup>(() => UserSignup());

  // Bloc
  sl.registerFactory<SignupBloc>(() => SignupBloc(userSignup: sl()));
}

void _initSignin() {
  // API Service
  sl.registerLazySingleton<LoginApiService>(() => LoginApiServiceImpl(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl(), sl()),
  );

  // UseCases
  sl.registerLazySingleton<UserLoginWithEmail>(() => UserLoginWithEmail(sl()));

  sl.registerLazySingleton<UserLoginWithPhone>(() => UserLoginWithPhone(sl()));

  // Bloc
  sl.registerFactory<SigninBloc>(() => SigninBloc(sl(), sl()));
}

void _initLocation() {
  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepository(sharedPreferences: sl()),
  );

  // Bloc
  sl.registerFactory<LocationBloc>(
    () => LocationBloc(locationRepository: sl()),
  );
}
