import 'dto/nft_moralis_dto.dart';

abstract class MoralisServiceDataSource {

  Future<NftsMoralisDto> fetchNftFromAddress(String address);
}