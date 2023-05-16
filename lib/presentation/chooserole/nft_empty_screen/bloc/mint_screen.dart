import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/presentation/chooserole/nft_empty_screen/bloc/nft_mint_bloc.dart';

import '../../../../di/service_locator.dart';
import 'nft_empty_event.dart';

class MintScreen extends StatelessWidget {
  final NftMintBloc bloc = serviceLocator();

  MintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NftMintBloc>(
      create: (context) => bloc..add(MintingNftEvent(role: 1)),
      child: const Scaffold(body: Text("Mint"),),
    );
  }
}
