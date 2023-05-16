abstract class NftMintEvent {}

class MintingNftEvent extends NftMintEvent {
  final int role;

  MintingNftEvent({required this.role});
}