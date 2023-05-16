import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:juding/datasource/contracts/mma_contract_data_source_impl.dart';
import 'package:juding/datasource/moralis/moralis_service_datasource_impl.dart';
import 'package:juding/datasource/newwallet/new_wallet_generate_datasource.dart';
import 'package:juding/datasource/newwallet/new_wallet_generate_datasource_impl.dart';
import 'package:juding/presentation/login/bloc/login_bloc.dart';
import 'package:juding/presentation/restorewallet/bloc/restore_wallet_bloc.dart';
import 'package:juding/repository/contract/mma_contract_repository_impl.dart';
import 'package:juding/repository/session/session_repository.dart';
import 'package:juding/repository/session/session_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import '../datasource/contracts/mma_contract_data_source.dart';
import '../datasource/localstorage/local_storage_data_source.dart';
import '../datasource/localstorage/local_storage_datasource_impl.dart';
import '../datasource/moralis/moralis_service_datasource.dart';
import '../presentation/chooserole/bloc/choose_role_bloc.dart';
import '../presentation/chooserole/nft_empty_screen/bloc/nft_mint_bloc.dart';
import '../presentation/registerwallet/pin/pincodeconfirm/cubit/pin_code_confirm_bloc.dart';
import '../presentation/registerwallet/twentywords/cubit/twenty_words_cubit.dart';
import '../presentation/registerwallet/twentywordsconfirm/bloc/seed_confirm_bloc.dart';
import '../repository/contract/mma_contract_repository.dart';
import '../repository/moralis/moralis_repository.dart';
import '../repository/moralis/moralis_repository_impl.dart';
import '../repository/register/register_repository.dart';
import '../repository/register/register_repository_impl.dart';
import 'package:http/http.dart';

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
  serviceLocator.registerLazySingleton<SessionRepository>(() =>
      SessionRepositoryImpl(
          localStorageDataSource: serviceLocator(),
          newWalletGenerateDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton<Web3Client>(() => Web3Client(
      "https://polygon-mumbai.g.alchemy.com/v2/-HDXjKFCb6gHWEy9GcLzLtBynOYo-JUe",
      Client()));

  serviceLocator.registerFactory<LoginBloc>(
      () => LoginBloc(repository: serviceLocator()));
  serviceLocator.registerFactory<RestoreWalletBloc>(
      () => RestoreWalletBloc(repository: serviceLocator()));
  serviceLocator.registerFactory<MoralisServiceDataSource>(
      () => MoralisServiceDataSourceImpl());
  serviceLocator.registerFactory<MoralisRepository>(
      () => MoralisRepositoryImpl(dataSource: serviceLocator()));
  serviceLocator.registerFactory<NftMintBloc>(
      () => NftMintBloc(mmaContractRepository: serviceLocator()));
  serviceLocator.registerFactory<MmaContractRepository>(() =>
      MmaContractRepositoryImpl(
          sessionRepository: serviceLocator(),
          mmaContractDataSource: serviceLocator()));
  serviceLocator.registerFactory<MmaContractDataSource>(
      () => MmaContractDataSourceImpl(web3client: serviceLocator()));
  serviceLocator.registerFactory<ChooseRoleBloc>(() => ChooseRoleBloc(
    sessionRepository: serviceLocator(),
    moralisRepository: serviceLocator(), mmaContractRepository: serviceLocator(),
  ));
}
