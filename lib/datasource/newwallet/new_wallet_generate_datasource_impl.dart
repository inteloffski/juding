import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:web3dart/credentials.dart';
import 'new_wallet_generate_datasource.dart';
import 'package:convert/convert.dart';

class NewWalletGenerateDataSourceImpl implements NewWalletGenerateDataSource {
 // static String privateKey = "";
  final String _path = "m/44'/60'/0'/1'/0'";
  String? _privateKey;

  @override
  // TODO: implement privateKey
  String? get privateKey => _privateKey;

  @override
  Future<List<String>> generateBip39() async {
    return bip39.generateMnemonic().split(' ');
  }

  @override
  Future<String> fetchPrivateKey(String mnemonic) async {
    String seed = bip39.mnemonicToSeedHex(mnemonic);
    List<int> seedBytes = hex.decode(seed);
    KeyData master = await ED25519_HD_KEY.derivePath(_path, seedBytes);
    _privateKey = hex.encode(master.key);
    return _privateKey ?? "";
  }

  @override
  bool validateMnemonic(String mnemonic) {
    if (bip39.validateMnemonic(mnemonic)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String fetchAddressWallet(String privateKey) {
    return EthPrivateKey.fromHex(privateKey).address.toString();
  }

}