import 'package:juding/repository/session_repository.dart';
import '../datasource/local_storage_data_source.dart';

class SessionRepositoryImpl implements SessionRepository {

  String? _address;

  final LocalStorageDataSource localStorageDataSource;

  SessionRepositoryImpl({required this.localStorageDataSource});

  @override
  String? get address => _address;

  @override
  Future<String> authSession(String key) async {
    String value = await localStorageDataSource.readSidFromLocalStorage(key);
    _address = value;
    return _address ?? "";
  }

}
