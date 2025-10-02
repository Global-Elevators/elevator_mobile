import 'package:dio/dio.dart';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/constants.dart';
import 'package:elevator/data/data_source/remote_data_source.dart';
import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/data/network/dio_factory.dart';
import 'package:elevator/data/network/network_info.dart';
import 'package:elevator/data/repository/repository.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/forget_password_usecase.dart';
import 'package:elevator/domain/usecase/login_usecase.dart';
import 'package:elevator/domain/usecase/register_usecase.dart';
import 'package:elevator/domain/usecase/resend_otp_usecase.dart';
import 'package:elevator/domain/usecase/reset_password_usecase.dart';
import 'package:elevator/domain/usecase/verify_forgot_password_usecase.dart';
import 'package:elevator/domain/usecase/verify_usecase.dart';
import 'package:elevator/presentation/forget_password/forget_password_viewmodel.dart';
import 'package:elevator/presentation/login/login_viewmodel.dart';
import 'package:elevator/presentation/new_password/new_password_viewmodel.dart';
import 'package:elevator/presentation/register/register_viewmodel.dart';
import 'package:elevator/presentation/verify/verify_viewmodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    // () => AppPreferences(instance<FlutterSecureStorage>()),
    () => AppPreferences(),
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
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance<Repository>()),
    );

    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(instance<LoginUseCase>()),
    );
  }
}

initVerifyModule() {
  if (!GetIt.I.isRegistered<VerifyUseCase>()) {
    instance.registerFactory<VerifyUseCase>(
      () => VerifyUseCase(instance<Repository>()),
    );

    instance.registerFactory<VerifyViewModel>(
      () => VerifyViewModel(
        instance<VerifyUseCase>(),
        instance<VerifyForgotPasswordUseCase>(),
        instance<ResendOtpUseCase>(),
      ),
    );
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance<Repository>()),
    );

    instance.registerFactory<ForgetPasswordViewmodel>(
      () => ForgetPasswordViewmodel(instance<ForgotPasswordUseCase>()),
    );
  }
}

initVerifyForgotPasswordModule() {
  if (!GetIt.I.isRegistered<VerifyForgotPasswordUseCase>()) {
    instance.registerFactory<VerifyForgotPasswordUseCase>(
      () => VerifyForgotPasswordUseCase(instance<Repository>()),
    );
  }
}

initResetPasswordModule() {
  if (!GetIt.I.isRegistered<ResetPasswordUsecase>()) {
    instance.registerFactory<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(instance<Repository>()),
    );

    instance.registerFactory<NewPasswordViewModel>(
      () => NewPasswordViewModel(instance<ResetPasswordUsecase>()),
    );
  }
}

initResendOtpModule() {
  if (!GetIt.I.isRegistered<ResendOtpUseCase>()) {
    instance.registerFactory<ResendOtpUseCase>(
      () => ResendOtpUseCase(instance<Repository>()),
    );
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(instance<Repository>()),
    );
    instance.registerFactory<RegisterViewModel>(
      () => RegisterViewModel(instance<RegisterUseCase>()),
    );
  }
}
