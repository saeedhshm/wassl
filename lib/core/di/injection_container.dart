import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/core/network/network_info.dart';
import 'package:wassl/features/auth/data/datasource/auth_data_sources.dart';
import 'package:wassl/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:wassl/features/auth/data/datasource/mock_auth_data_source.dart';
import 'package:wassl/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:wassl/features/auth/domain/repositories/auth_repository.dart';
import 'package:wassl/features/auth/domain/usecases/auth_usecases.dart';
import 'package:wassl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wassl/features/orders/data/datasource/orders_data_sources.dart';
import 'package:wassl/features/orders/data/datasource/mock_orders_data_source.dart';
import 'package:wassl/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:wassl/features/orders/domain/repositories/orders_repository.dart';
import 'package:wassl/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:wassl/features/attendance/data/datasource/attendance_data_sources.dart';
import 'package:wassl/features/attendance/data/datasource/mock_attendance_data_source.dart';
import 'package:wassl/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:wassl/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:wassl/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:wassl/features/home/data/datasource/home_data_sources.dart';
import 'package:wassl/features/home/data/datasource/mock_home_data_source.dart';
import 'package:wassl/features/home/data/repositories/home_repository.dart';
import 'package:wassl/features/home/domain/repositories/home_repository.dart';
import 'package:wassl/features/home/presentation/cubit/home_cubit.dart';
import 'package:wassl/features/finance/data/datasource/finance_data_sources.dart';
import 'package:wassl/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:wassl/features/finance/domain/repositories/finance_repository.dart';
import 'package:wassl/features/finance/presentation/cubit/finance_cubit.dart';
import 'package:wassl/features/vacations/data/datasource/vacations_data_sources.dart';
import 'package:wassl/features/vacations/data/repositories/vacations_repository_impl.dart';
import 'package:wassl/features/vacations/domain/repositories/vacations_repository.dart';
import 'package:wassl/features/vacations/presentation/cubit/vacations_cubit.dart';
import 'package:wassl/features/profile/data/datasource/profile_data_sources.dart';
import 'package:wassl/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:wassl/features/profile/domain/repositories/profile_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies({bool useMocks = true}) async {
  await _initCore();
  await _initAuth(useMocks: useMocks);
  await _initOrders(useMocks: useMocks);
  await _initAttendance(useMocks: useMocks);
  await _initHome(useMocks: useMocks);
  await _initFinance(useMocks: useMocks);
  await _initVacations(useMocks: useMocks);
  await _initProfile(useMocks: useMocks);
}

Future<void> _initCore() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
    return dio;
  });

  sl.registerLazySingleton(() => ApiClient(
        baseUrl: ApiEndpoints.baseUrl,
        dio: sl(),
      ));
}

Future<void> _initAuth({bool useMocks = true}) async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => useMocks ? MockAuthRemoteDataSource() : AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => SaveCredentialsUseCase(sl()));

  sl.registerFactory(() => AuthCubit(
        loginUseCase: sl(),
        logoutUseCase: sl(),
        changePasswordUseCase: sl(),
        getCurrentUserUseCase: sl(),
        saveCredentialsUseCase: sl(),
      ));
}

Future<void> _initOrders({bool useMocks = true}) async {
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => useMocks ? MockOrdersRemoteDataSource() : OrdersRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(sl()));
  sl.registerFactory(() => OrdersCubit(repository: sl()));
}

Future<void> _initAttendance({bool useMocks = true}) async {
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => useMocks ? MockAttendanceRemoteDataSource() : AttendanceRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AttendanceRepository>(() => AttendanceRepositoryImpl(sl()));
  sl.registerFactory(() => AttendanceCubit(repository: sl()));
}

Future<void> _initHome({bool useMocks = true}) async {
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => useMocks ? MockHomeRemoteDataSource() : HomeRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeDataSource: sl()));
  sl.registerFactory(() => HomeCubit(repository: sl()));
}

Future<void> _initFinance({bool useMocks = true}) async {
  sl.registerLazySingleton<FinanceRemoteDataSource>(
    () => useMocks ? MockFinanceRemoteDataSource() : FinanceRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FinanceRepository>(() => FinanceRepositoryImpl(sl()));
  sl.registerFactory(() => FinanceCubit(repository: sl()));
}

Future<void> _initVacations({bool useMocks = true}) async {
  sl.registerLazySingleton<VacationsRemoteDataSource>(
    () => useMocks ? MockVacationsRemoteDataSource() : VacationsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<VacationsRepository>(() => VacationsRepositoryImpl(sl()));
  sl.registerFactory(() => VacationsCubit(repository: sl()));
}

Future<void> _initProfile({bool useMocks = true}) async {
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => useMocks ? MockProfileRemoteDataSource() : ProfileRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
}
