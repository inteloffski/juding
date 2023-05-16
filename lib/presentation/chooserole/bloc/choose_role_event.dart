abstract class ChooseRoleEvent {}

class LoadedDataEvent extends ChooseRoleEvent {}

class RefreshDataEvent extends ChooseRoleEvent {
  final int role;

  RefreshDataEvent(this.role);
}