abstract class SeedConfirmEvent {}

class CheckingSeedEvent extends SeedConfirmEvent {
  final List<String> seedEntered;
  final List<String> seedPass;

  CheckingSeedEvent({required this.seedEntered, required this.seedPass});
}