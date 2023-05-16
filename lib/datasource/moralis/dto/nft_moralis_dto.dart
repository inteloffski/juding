import 'package:equatable/equatable.dart';

class NftsMoralisDto {
  final int? total;
  final int page;
  final int pageSize;
  final String? cursor;
  final List<NftDto> result;

  const NftsMoralisDto({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.cursor,
    required this.result});

  factory NftsMoralisDto.fromJson(Map<String, dynamic> json){
    final resultData = json['result'] as List<dynamic>?;
    final result = resultData != null
            ? resultData.map((result) => NftDto.fromJson(result)).toList()
            : <NftDto>[];

    return NftsMoralisDto(
        total: json["total"],
        page: json["page"],
        pageSize: json["page_size"],
        cursor: json["cursor"],
        result: result,
    );
  }
}

class NftDto extends Equatable {
  final String tokenAddress;
  final String tokenId;
  final String amount;
  final String ownerOf;
  final String tokenHash;
  final String blockNumberMinted;
  final String blocNumber;
  final String contractType;
  final String? name;
  final String? symbol;
  final String? tokenUri;
  final String lastTokenUriSync;
  final String? lastMetadataSync;
  final String? minterAddress;
  final bool possibleSpam;

  const NftDto({required this.tokenAddress,
    required this.tokenId,
    required this.amount,
    required this.ownerOf,
    required this.tokenHash,
    required this.blockNumberMinted,
    required this.blocNumber,
    required this.contractType,
    required this.name,
    required this.symbol,
    required this.tokenUri,
    required this.lastTokenUriSync,
    required this.lastMetadataSync,
    required this.minterAddress,
    required this.possibleSpam});

  factory NftDto.fromJson(Map<String, dynamic> json) {
    return NftDto(
      tokenAddress: json["token_address"],
      tokenId: json["token_id"],
      amount: json["amount"],
      ownerOf: json["owner_of"],
      tokenHash: json["token_hash"],
      blockNumberMinted: json["block_number_minted"],
      blocNumber: json["block_number"],
      contractType: json["contract_type"],
      name: json["name"],
      symbol: json["symbol"],
      tokenUri: json["token_uri"],
      lastTokenUriSync: json["last_token_uri_sync"],
      lastMetadataSync: json["last_metadata_sync"],
      minterAddress: json["minter_address"],
      possibleSpam: json["possible_spam"],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        tokenAddress,
        tokenId,
        amount,
        ownerOf,
        tokenHash,
        blockNumberMinted,
        blocNumber,
        contractType,
        name,
        symbol,
        tokenUri,
        lastTokenUriSync,
        lastMetadataSync,
        minterAddress,
        possibleSpam
      ];
}
