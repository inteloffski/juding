import 'package:juding/repository/register/register_repository.dart';

import '../../datasource/localstorage/local_storage_data_source.dart';
import '../../datasource/newwallet/new_wallet_generate_datasource.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NewWalletGenerateDataSource newWalletGenerateDataSource;
  final LocalStorageDataSource localStorageDataSource;

  RegisterRepositoryImpl({
    required this.newWalletGenerateDataSource,
    required this.localStorageDataSource,
  });

  @override
  Future<void> registerNewWallet(String key, String mnemonic) async {
    final privateKey =
        await newWalletGenerateDataSource.fetchPrivateKey(mnemonic);
    newWalletGenerateDataSource.fetchAddressWallet(privateKey);
    localStorageDataSource.writeSeedToLocalStorage(key, mnemonic);
  }

  @override
  Future<List<String>> fetchSeed() {
    return newWalletGenerateDataSource.generateBip39();
  }

  @override
  bool validateMnemonic(String mnemonic) {
    if (newWalletGenerateDataSource.validateMnemonic(mnemonic)) {
      return true;
    } else {
      return false;
    }
  }
}
