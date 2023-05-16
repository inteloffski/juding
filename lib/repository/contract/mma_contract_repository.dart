abstract class MmaContractRepository {
  Future<String> mint(int role);

  Future<String> cardInfo(int tokenId);
}