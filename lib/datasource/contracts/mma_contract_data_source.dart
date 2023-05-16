abstract class MmaContractDataSource {

  Future<String> mint(String privateKey, int role);

  Future<List<dynamic>> cardInfo(String privateKey, int tokenId);
}