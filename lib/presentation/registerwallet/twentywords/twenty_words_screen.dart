import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/service_locator.dart';
import '../../commonwidgets/common_widgets.dart';
import 'cubit/twenty_words_cubit.dart';
import 'cubit/twenty_words_state.dart';

class TwentyWordsScreen extends StatelessWidget {
  const TwentyWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TwentyWordsCubit>(
      create: (context) => serviceLocator<TwentyWordsCubit>(),
      child: Scaffold(
        appBar: NftAppBar(
          appBarTitle: 'generate_seed_screen.title'.tr(),
        ),
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'generate_seed_screen.subtitle'.tr(),
                    style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.normal),
                    textAlign: TextAlign.start,
                  ),
                ),
                BlocBuilder<TwentyWordsCubit, TwentyWordsState>(
                  builder: (context, state) {
                    if (state is ListWordsState) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.words.length,
                          itemBuilder: (context, index) =>
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(
                                            24.0)),
                                    child: Text(
                                      state.words[index],
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                BlocBuilder<TwentyWordsCubit, TwentyWordsState>(
                  builder: (context, state) {
                    if (state is ListWordsState) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: NftButton(
                              textButton: 'next_button'.tr(),
                              width: double.infinity,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/twentyWords/twentyWordsConfirm',
                                    arguments: state.words);
                              },
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}
