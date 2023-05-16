import 'package:juding/datasource/moralis/dto/nft_moralis_dto.dart';
import 'package:juding/datasource/moralis/moralis_service_datasource.dart';

import 'moralis_repository.dart';

class MoralisRepositoryImpl extends MoralisRepository {
  final MoralisServiceDataSource dataSource;

  MoralisRepositoryImpl({required this.dataSource});

  @override
  Future<NftsMoralisDto> fetchNftFromAddress(String address) {
    return dataSource.fetchNftFromAddress(address);
  }
}
