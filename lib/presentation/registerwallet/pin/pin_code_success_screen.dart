import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:juding/di/service_locator.dart';
import 'package:juding/repository/session_repository.dart';
import 'package:juding/repository/session_repository_impl.dart';
import '../../commonwidgets/common_widgets.dart';

class PinCodeSuccessScreen extends StatefulWidget {
  const PinCodeSuccessScreen({super.key});

  @override
  State<PinCodeSuccessScreen> createState() => _PinCodeSuccessScreen();
}

class _PinCodeSuccessScreen extends State<PinCodeSuccessScreen> {
  final SessionRepository repository = serviceLocator();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // ToggleButtons with a single selection.
              Text("${repository.address}", style: TextStyle(fontSize: 24),),
              // ToggleButtons with a multiple selection.
            ],
          ),
        ),
      ),
    );
  }
}
