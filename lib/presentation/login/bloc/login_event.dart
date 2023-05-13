abstract class LoginEvent {}

class ValidateLoginEvent extends LoginEvent {
  final String password;

  ValidateLoginEvent({required this.password});
}