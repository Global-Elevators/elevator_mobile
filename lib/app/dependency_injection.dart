import 'package:dio/dio.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/data/data_source/remote_data_source.dart';
import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/data/network/dio_factory.dart';
import 'package:elevator/data/network/network_info.dart';
import 'package:elevator/data/repository/repository.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/login_usecase.dart';
import 'package:elevator/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance; // Singleton instance of GetIt
Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  ); // This line registers the SharedPreferences instance as a lazy singleton in the GetIt instance.

  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance<SharedPreferences>()),
  );

  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker.instance),
  );

  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance<AppPreferences>()),
  );

  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServicesClient>(
    () => AppServicesClient(dio),
  );

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImp(instance<AppServicesClient>()),
  );

  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()),
  );
}

// This function has all the dependencies that are used in the login module.
initLoginModule() {
  if (!GetIt.I
      .isRegistered<
        LoginUseCase
      >())
  {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance<Repository>()),
    );

    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(instance<LoginUseCase>()),
    );
  }
}
