import '../../datasource/moralis/dto/nft_moralis_dto.dart';

abstract class MoralisRepository {

  Future<NftsMoralisDto> fetchNftFromAddress(String address);
}