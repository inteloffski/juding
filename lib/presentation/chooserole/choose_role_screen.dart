import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/di/service_locator.dart';
import 'package:juding/presentation/chooserole/nft_empty_screen/bloc/nft_mint_bloc.dart';
import 'package:juding/presentation/chooserole/nft_empty_screen/nft_empty_screen.dart';
import 'package:juding/presentation/commonwidgets/common_widgets.dart';
import 'bloc/choose_role_bloc.dart';
import 'bloc/choose_role_event.dart';
import 'bloc/choose_role_state.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _PinCodeSuccessScreen();
}

class _PinCodeSuccessScreen extends State<ChooseRoleScreen> {
  @override
  Widget build(BuildContext context) {
    final ChooseRoleBloc bloc = serviceLocator();
    final NftMintBloc emptyBloc = serviceLocator();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChooseRoleBloc>(
            create: (context) => bloc..add(LoadedDataEvent())),
        BlocProvider<NftMintBloc>(create: (context) => emptyBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose role'),
        ),
        body: BlocConsumer<ChooseRoleBloc, ChooseRoleState>(
            builder: (_, state) {
              if (state is LoadingChooseState) {
                return Center(child: _loadingProgressIndicatorStateWidget());
              } else if (state is SuccessChooseState) {
                return Column(
                    children: const [
                      Center(
                        child: Text("Success"),
                      ),
                      Card(
                        child: Text("Event 1"),
                      ),
                      Card(
                        child: Text("Event 2"),
                      ),
                      Card(
                        child: Text("Event 3"),
                      ),
                    ],
                );
              } else if (state is UserTokenEmptyChooseState) {
                return const NftEmptyScreen();
              } else if (state is ErrorChooseState) {
                return const Center(
                  child: Text("ErrorChooseState"),
                );
              } else if (state is RefreshAfterMintingSuccessState) {
                return Column(
                  children: [
                    Center(
                      child: Text("Refresh success ${state.role}"),
                    ),
                    const Card(
                      child: Text("Event 1"),
                    ),
                    const Card(
                      child: Text("Event 2"),
                    ),
                    const Card(
                      child: Text("Event 3"),
                    ),
                  ],
                );
              } else if (state is RefreshAfterMintingErrorState) {
                return const Text("RefreshAfterMintingErrorState");
              } else {
                return const Text("");
              }
            },
            listener: (state, context) {}),
      ),
    );
  }

  Widget _loadingProgressIndicatorStateWidget() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: CircularProgressIndicator(),
    );
  }
}
