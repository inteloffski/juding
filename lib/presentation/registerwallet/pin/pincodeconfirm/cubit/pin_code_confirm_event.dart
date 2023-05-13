abstract class PinCodeEvent {}

class PinCodeCheckingEvent extends PinCodeEvent {
  final String pinCodeEntered;
  final String pinCodeConfirmed;
  final String seed;

  PinCodeCheckingEvent({required this.pinCodeEntered, required this.pinCodeConfirmed, required this.seed});
}