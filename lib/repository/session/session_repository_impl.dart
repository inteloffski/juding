import 'package:juding/repository/session/session_repository.dart';
import '../../datasource/localstorage/local_storage_data_source.dart';
import '../../datasource/newwallet/new_wallet_generate_datasource.dart';

class SessionRepositoryImpl implements SessionRepository {
  String? _address;
  String? _privateKey;

  final LocalStorageDataSource localStorageDataSource;
  final NewWalletGenerateDataSource newWalletGenerateDataSource;

  SessionRepositoryImpl(
      {required this.localStorageDataSource,
      required this.newWalletGenerateDataSource});

  @override
  String? get address => _address;

  @override
  // TODO: implement privateKey
  String? get privateKey => _privateKey;

  @override
  Future<String> authSession(String key) async {
    String seed = await localStorageDataSource.readSidFromLocalStorage(key);
    final privateKey = await newWalletGenerateDataSource.fetchPrivateKey(seed);
    _privateKey = privateKey;
    _address = newWalletGenerateDataSource.fetchAddressWallet(privateKey);
    return _address ?? "";
  }

  @override
  Future<String> fetchPrivateKey(String key) async {
    return await authSession(key);
  }
}
