abstract class MmaContractRepository {
  Future<String> mint(int role);

  Future<List<dynamic>> cardInfo(int tokenId);
}