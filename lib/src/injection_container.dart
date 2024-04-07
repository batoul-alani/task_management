import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:maids_tasks_manager/src/database/database_helper.dart';
import 'package:maids_tasks_manager/src/features/tasks/data/tasks_local_repository.dart';
import 'package:maids_tasks_manager/src/features/tasks/data/tasks_repository.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_local_cubit.dart';
import 'package:maids_tasks_manager/src/features/tasks/persentition/cubit/tasks_remote_cubit.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';
import 'package:maids_tasks_manager/src/features/authantication/data/auth_repository.dart';
import 'package:maids_tasks_manager/src/features/authantication/presentation/cubit/login_cubit.dart';
import 'package:maids_tasks_manager/src/network/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Application
  getIt.registerLazySingleton(() => AppCubit(getIt()));

  // Login
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(networkService: getIt()));
  getIt.registerFactory(() => LoginCubit());

  // Tasks
  getIt.registerFactory(() => TasksRemoteCubit());
  getIt.registerFactory(() => TasksLocalCubit());
  getIt.registerLazySingleton<TaskRepository>(
      () => TaskRepository(networkService: getIt()));
  getIt.registerLazySingleton<TasksLocalRepository>(
      () => TasksLocalRepository(database: getIt()));

  // Database
  final Database database = await DatabaseHelper().db;
  getIt.registerLazySingleton(() => database);

  // Storage
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Dio
  getIt.registerLazySingleton<NetworkService<Response>>(
      () => DioNetworkService());
}

void resetApp() async {
  await getIt.reset();
  await init();
}
