import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/chooserole/bloc/choose_role_event.dart';
import 'package:juding/presentation/chooserole/bloc/choose_role_state.dart';

import '../../../datasource/moralis/dto/nft_moralis_dto.dart';
import '../../../repository/contract/mma_contract_repository.dart';
import '../../../repository/moralis/moralis_repository.dart';
import '../../../repository/session/session_repository.dart';

class ChooseRoleBloc extends Bloc<ChooseRoleEvent, ChooseRoleState> {
  final MoralisRepository moralisRepository;
  final SessionRepository sessionRepository;
  final MmaContractRepository mmaContractRepository;

  ChooseRoleBloc({
    required this.moralisRepository,
    required this.sessionRepository,
    required this.mmaContractRepository
  }) : super(LoadingChooseState()) {
    on<LoadedDataEvent>((event, emit) async {
      try {
        NftsMoralisDto nftsMoralisDto = await moralisRepository
            .fetchNftFromAddress(sessionRepository.address!);


        if (nftsMoralisDto.result.isNotEmpty) {
          final num tokenId = num.parse(nftsMoralisDto.result.first.tokenId);
          final List<dynamic> _tokenId = await mmaContractRepository.cardInfo(tokenId.toInt());
          final String role = _convertIdToRole(_tokenId.first);
          emit(SuccessChooseState(role));
        } else {
          emit(UserTokenEmptyChooseState());
        }
      } catch (e) {
        emit(ErrorChooseState(e.toString()));
      }
    });

    on<RefreshDataEvent>((event, emit) async {
      emit(LoadingChooseState());
      try {
        NftsMoralisDto nftsMoralisDto = await moralisRepository.fetchNftFromAddress(sessionRepository.address!);
        final num tokenId = num.parse(nftsMoralisDto.result.first.tokenId);
        final List<dynamic> t = await mmaContractRepository.cardInfo(tokenId.toInt());
        final String role = _convertIdToRole(t.first) ;
        emit(
          RefreshAfterMintingSuccessState(
            role: role,
          ),
        );
      } catch (e) {
        emit(RefreshAfterMintingErrorState(e.toString()));
      }
    });
  }

  //Fighter 0
  // Fan 1
  // Judge 2
  String _convertIdToRole(BigInt tokenId){
    if(tokenId == BigInt.from(0)){
      return "Fighter";
    } else if(tokenId == BigInt.from(0)){
      return "Fan";
    } else {
      return "Judge";
    }
  }
}
