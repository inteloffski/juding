abstract class RestoreWalletEvent {}

class ValidateRestoreEvent extends RestoreWalletEvent{
  final String mnemonic;

  ValidateRestoreEvent({required this.mnemonic});
}