abstract class MmaContractDataSource {

  Future<String> mint(String privateKey, int role);

  Future<String> cardInfo(String privateKey, int tokenId);
}