import 'package:juding/datasource/contracts/mma_contract_data_source.dart';
import 'package:juding/repository/session/session_repository.dart';

import 'mma_contract_repository.dart';

class MmaContractRepositoryImpl extends MmaContractRepository {
  final SessionRepository sessionRepository;
  final MmaContractDataSource mmaContractDataSource;

  MmaContractRepositoryImpl(
      {required this.sessionRepository, required this.mmaContractDataSource});

  @override
  Future<String> mint(int role) async {
    return await mmaContractDataSource.mint(sessionRepository.privateKey!, role);
  }

  @override
  Future<List<dynamic>> cardInfo(int tokenId) async {
    return await mmaContractDataSource.cardInfo(sessionRepository.privateKey!, tokenId);
  }


}
