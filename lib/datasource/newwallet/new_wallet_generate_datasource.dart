abstract class NewWalletGenerateDataSource {

  String? get privateKey;

  Future<List<String>> generateBip39();

  Future<String> fetchPrivateKey(String mnemonic);

  String fetchAddressWallet(String privateKey);

  bool validateMnemonic(String mnemonic);
}