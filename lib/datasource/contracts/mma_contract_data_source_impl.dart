import 'package:flutter/services.dart';
import 'package:juding/datasource/contracts/mma_contract_data_source.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class MmaContractDataSourceImpl extends MmaContractDataSource {
  final Web3Client web3client;


  MmaContractDataSourceImpl({required this.web3client});

  @override
  Future<String> mint(String privateKey, int role) async {
    const String mintFunctionFromContract = "mint";
    String localPathContract = await rootBundle.loadString("assets/contracts/mma_contract.json");
    const String contractName = "MMARoleNFT";
    const String prodReplenishmentAddress = "0x23cb1BEe06122a71F8A56F66AEFD34614d43c8f5";
    const int chainId = 80001;
    final contract = DeployedContract(
      ContractAbi.fromJson(localPathContract, contractName),
      EthereumAddress.fromHex(prodReplenishmentAddress),
    );

    final Credentials credentials = EthPrivateKey.fromHex(privateKey);

    return await web3client.sendTransaction(
        credentials,
        Transaction.callContract(
          maxGas: 110000,
          contract: contract,
          function: contract.function(mintFunctionFromContract),
          parameters: [BigInt.from(role)],
        ),
        chainId: chainId
    );
  }

  @override
  Future<List<dynamic>> cardInfo(String privateKey, int tokenId) async {
    const String cardInfoFunctionFromContract = "cardInfo";
    String localPathContract = await rootBundle.loadString("assets/contracts/mma_contract.json");
    const String contractName = "MMARoleNFT";
    const String prodReplenishmentAddress = "0x23cb1BEe06122a71F8A56F66AEFD34614d43c8f5";
    const int chainId = 80001;
    final contract = DeployedContract(
      ContractAbi.fromJson(localPathContract, contractName),
      EthereumAddress.fromHex(prodReplenishmentAddress),
    );
    final Credentials credentials = EthPrivateKey.fromHex(privateKey);

    return await web3client.call(
        contract: contract,
        function: contract.function(cardInfoFunctionFromContract),
        params: [BigInt.from(tokenId)],
    );
  }
}
