abstract class SessionRepository {
  String? get address;
  String? get privateKey;

  Future<String> authSession(String key);

  Future<String> fetchPrivateKey(String key);
}
