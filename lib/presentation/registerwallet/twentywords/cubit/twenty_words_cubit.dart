import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/registerwallet/twentywords/cubit/twenty_words_state.dart';

import '../../../../repository/register/register_repository.dart';


class TwentyWordsCubit extends Cubit<TwentyWordsState> {
  final RegisterRepository registerRepository;

  TwentyWordsCubit({required this.registerRepository})
      : super(InitWordsState()) {
    fetchWords();
  }

  void fetchWords() async {
    final words = await registerRepository.fetchSeed();
    emit(ListWordsState(words));
  }
}
