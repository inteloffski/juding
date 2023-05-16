abstract class RegisterRepository {
  Future<void> registerNewWallet(String key, String mnemonic);

  Future<List<String>> fetchSeed();

  bool validateMnemonic(String mnemonic);
}
