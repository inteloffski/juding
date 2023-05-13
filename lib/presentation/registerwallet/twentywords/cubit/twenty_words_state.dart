import 'package:equatable/equatable.dart';

abstract class TwentyWordsState extends Equatable {
  const TwentyWordsState();

  @override
  List<Object?> get props => [];
}

class InitWordsState extends TwentyWordsState {
  @override
  List<Object?> get props => [];
}

class ListWordsState extends TwentyWordsState {
  final List<String> words;

  const ListWordsState(this.words);

  @override
  List<Object?> get props => [words];
}
