import 'package:equatable/equatable.dart';

import '../../../datasource/moralis/dto/nft_moralis_dto.dart';

abstract class ChooseRoleState extends Equatable {
  const ChooseRoleState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Test extends ChooseRoleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingChooseState extends ChooseRoleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessChooseState extends ChooseRoleState {
  final String role;

  const SuccessChooseState(this.role);

  @override
  // TODO: implement props
  List<Object?> get props => [role];

}

class UserTokenEmptyChooseState extends ChooseRoleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorChooseState extends ChooseRoleState {
  final String messageError;

  const ErrorChooseState(this.messageError);

  @override
  // TODO: implement props
  List<Object?> get props => [messageError];

}

class RefreshAfterMintingSuccessState extends ChooseRoleState {
  final String role;

  const RefreshAfterMintingSuccessState({required this.role});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RefreshAfterMintingErrorState extends ChooseRoleState {
  final String error;

  const RefreshAfterMintingErrorState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}