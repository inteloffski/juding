import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/chooserole/nft_empty_screen/bloc/nft_empty_event.dart';
import 'package:juding/presentation/chooserole/nft_empty_screen/bloc/nft_empty_state.dart';

import '../../../../repository/contract/mma_contract_repository.dart';

class NftMintBloc extends Bloc<NftMintEvent, MintNftState> {
  final MmaContractRepository mmaContractRepository;

  NftMintBloc({required this.mmaContractRepository})
      : super(MintNftInitState()) {
    on<MintingNftEvent>((event, emit) async {
      emit(MintingNftState());
      try {
        await mmaContractRepository.mint(event.role);
        emit(MintedNftSuccessState());
      } catch (e) {
        emit(MintedNftErrorState());
      }
    });
  }
}
