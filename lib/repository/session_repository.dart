abstract class SessionRepository {
  String? get address;

  Future<String> authSession(String key);
}
