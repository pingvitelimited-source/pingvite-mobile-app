part of 'service_locator_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependecies() async {
  sl.registerLazySingleton<SizeConfig>(() => SizeConfig());

  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  // Signup Feature
  _initSignup();

  // Signin Feature
  _initSignin();
}

void _initSignup() {
  // API Service
  sl.registerLazySingleton<SignupApiService>(
    () => SignupApiServiceImpl(),
  );

  // Repository
  sl.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(),
  );

  // UseCase
  sl.registerLazySingleton<UserSignup>(
    () => UserSignup(),
  );

  // Bloc
  sl.registerFactory<SignupBloc>(
    () => SignupBloc(userSignup: sl()),
  );
}

void _initSignin() {
  // API Service
  sl.registerLazySingleton<LoginApiService>(
    () => LoginApiServiceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl(), sl()),
  );

  // UseCases
  sl.registerLazySingleton<UserLoginWithEmail>(
    () => UserLoginWithEmail(sl()),
  );

  sl.registerLazySingleton<UserLoginWithPhone>(
    () => UserLoginWithPhone(sl()),
  );

  // Bloc
  sl.registerFactory<SigninBloc>(
    () => SigninBloc(sl(), sl()),
  );
}
