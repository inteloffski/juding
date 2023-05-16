import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juding/di/service_locator.dart';
import 'package:juding/repository/session/session_repository.dart';
import '../bloc/choose_role_bloc.dart';
import '../bloc/choose_role_event.dart';
import 'bloc/nft_empty_event.dart';
import 'bloc/nft_empty_state.dart';
import 'bloc/nft_mint_bloc.dart';

class NftEmptyScreen extends StatefulWidget {
  const NftEmptyScreen({super.key});

  @override
  State<NftEmptyScreen> createState() => _NftEmptyScreenState();
}

class _NftEmptyScreenState extends State<NftEmptyScreen> {
  int? _value;

  final Color borderColor = const Color.fromRGBO(114, 178, 238, 1);
  final Color fillColor = const Color.fromRGBO(222, 231, 240, .57);

  @override
  Widget build(BuildContext context) {
    final SessionRepository repository = serviceLocator();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextButton(
            child: Text(
              repository.address!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: repository.address!)).then((value) { //only if ->
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Address copied to the clipboard")));
              });
            },
          ),
        ),
        Expanded(
          flex: 9,
          child: Center(
            child: Wrap(
              spacing: 24.0,
              children: List<Widget>.generate(
                3,
                (int index) {
                  return ChoiceChip(
                    disabledColor: fillColor,
                    selectedColor: borderColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(child: _titleFromIndex(index))),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _colorButtonIsActive(_value),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                minimumSize: const Size(double.infinity, 24),
              ),
              onPressed: () {
                if (_value != null) {
                  navigateTo(_value!, context);
                } else {
                  null;
                }
              },
              child:
                  BlocConsumer<NftMintBloc, MintNftState>(builder: (_, state) {
                if (state is MintNftInitState) {
                  return const Text(
                    'mint',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  );
                } else if (state is MintingNftState) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MintedNftSuccessState) {
                  return Text("Success");
                } else {
                  return Text("Error");
                }
              }, listener: (context, state) {
                if (state is MintedNftSuccessState) {
                  BlocProvider.of<ChooseRoleBloc>(context)
                      .add(RefreshDataEvent(_value!));
                }
              }),
            ),
          ),
        ),
      ],
    );
  }

  void navigateTo(int value, BuildContext context) {
    BlocProvider.of<NftMintBloc>(context).add(MintingNftEvent(role: value));
  }

  Widget _titleFromIndex(int index) {
    if (index == 0) {
      return Text('choose_role_screen.role_fighter'.tr());
    } else if (index == 1){
      return Text('choose_role_screen.role_fan'.tr());
    } else {
      return Text('choose_role_screen.role_judge'.tr());
    }
  }

  Color _colorButtonIsActive(int? index) {
    return index != null ? borderColor : fillColor;
  }
}
