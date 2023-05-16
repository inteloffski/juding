import 'dart:convert';

import 'package:juding/datasource/moralis/dto/nft_moralis_dto.dart';

import 'moralis_service_datasource.dart';
import 'package:http/http.dart' as http;

class MoralisServiceDataSourceImpl extends MoralisServiceDataSource {
  final String _baseUrl = "deep-index.moralis.io";
  final int _successStatusCode = 200;
  final Map<String, String> _header = {
    'Accept': 'application/json',
    'X-API-Key': 'KYX8OivOGcH7TIcQ7XjlcBhTLe4XZB20NfMi5Cf41DBaJyiN1q6IEuuB7c9Fj9G2',
  };

  @override
  Future<NftsMoralisDto> fetchNftFromAddress(String address) async {
    final path = "/api/v2/$address/nft";
    const String chainQuery = "chain";
    const String formatQuery = "format";
    const String mediaItemsQuery = "media_items";

    final uri = Uri.https(_baseUrl, path, {chainQuery: "mumbai", formatQuery: "decimal", mediaItemsQuery: "false"});
    final response = await http.get(uri, headers: _header);

    if (response.statusCode == _successStatusCode) {
      return NftsMoralisDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('An error has occurred');
    }
  }
}
