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

  // Contact Feature
  _initContact();

  // Location Search Feature
  _initLocationSearch();

  // Forgot Password Feature
  _initForgotPassword();
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

void _initContact() {
  // Data Source
  sl.registerLazySingleton<ContactRemoteDataSource>(
    () => ContactRemoteDataSourceImpl(dioClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCase
  sl.registerLazySingleton<CreateContactUseCase>(
    () => CreateContactUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<CreateContactBloc>(
    () => CreateContactBloc(createContactUseCase: sl()),
  );
}

void _initLocationSearch() {
  // Data Source
  sl.registerLazySingleton<LocationSearchDataSource>(
    () => LocationSearchDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<LocationSearchRepository>(
    () => LocationSearchRepositoryImpl(dataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton<SearchCountriesUseCase>(
    () => SearchCountriesUseCase(sl()),
  );
  sl.registerLazySingleton<SearchStatesUseCase>(
    () => SearchStatesUseCase(sl()),
  );
  sl.registerLazySingleton<SearchCitiesUseCase>(
    () => SearchCitiesUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<LocationSearchBloc>(
    () => LocationSearchBloc(
      searchCountriesUseCase: sl(),
      searchStatesUseCase: sl(),
      searchCitiesUseCase: sl(),
    ),
  );
}

void _initForgotPassword() {
  // API Services
  sl.registerLazySingleton<VerifyUserApiService>(
    () => VerifyUserApiServiceImpl(),
  );
  sl.registerLazySingleton<ForgotPasswordApiService>(
    () => ForgotPasswordApiServiceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<VerifyUserRepository>(
    () => VerifyUserRepositoryImpl(),
  );
  sl.registerLazySingleton<ForgotPasswordRepository>(
    () => ForgotPasswordRepositoryImpl(),
  );

  // UseCases
  sl.registerLazySingleton<VerifyUserUseCase>(() => VerifyUserUseCase());
  sl.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase());

  // Blocs
  sl.registerFactory<VerifyUserBloc>(() => VerifyUserBloc());
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc());
}
