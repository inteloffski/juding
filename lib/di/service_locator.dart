import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:juding/datasource/new_wallet_generate_datasource.dart';
import 'package:juding/datasource/new_wallet_generate_datasource_impl.dart';
import 'package:juding/presentation/login/bloc/login_bloc.dart';
import 'package:juding/presentation/restorewallet/bloc/restore_wallet_bloc.dart';
import 'package:juding/repository/session_repository.dart';
import 'package:juding/repository/session_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasource/local_storage_data_source.dart';
import '../datasource/local_storage_datasource_impl.dart';
import '../presentation/registerwallet/pin/pincodeconfirm/cubit/pin_code_confirm_bloc.dart';
import '../presentation/registerwallet/twentywords/cubit/twenty_words_cubit.dart';
import '../presentation/registerwallet/twentywordsconfirm/bloc/seed_confirm_bloc.dart';
import '../repository/register_repository.dart';
import '../repository/register_repository_impl.dart';

final serviceLocator = GetIt.instance;

init() async {
  // Local storage
  serviceLocator.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  //Data sources
  serviceLocator.registerLazySingleton<LocalStorageDataSource>(() =>
      LocalStorageDataSourceImpl(
          storage: const FlutterSecureStorage(), prefs: serviceLocator()));
  serviceLocator.registerFactory<NewWalletGenerateDataSource>(
      () => NewWalletGenerateDataSourceImpl());
  serviceLocator.registerFactory(() => SeedConfirmBloc());

  serviceLocator.registerFactory<RegisterRepository>(() =>
      RegisterRepositoryImpl(
          newWalletGenerateDataSource: serviceLocator(),
          localStorageDataSource: serviceLocator()));
  serviceLocator.registerFactory(
      () => TwentyWordsCubit(registerRepository: serviceLocator()));
  serviceLocator.registerFactory(() => PinCodeConfirmBloc(
      registerRepository: serviceLocator(),
      sessionRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<SessionRepository>(() => SessionRepositoryImpl(localStorageDataSource: serviceLocator()));

  serviceLocator.registerFactory<LoginBloc>(() => LoginBloc(repository: serviceLocator()));
  serviceLocator.registerFactory<RestoreWalletBloc>(() => RestoreWalletBloc(repository: serviceLocator()));
}
