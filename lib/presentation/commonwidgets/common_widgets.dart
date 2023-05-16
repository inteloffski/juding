import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_svg/svg.dart';

class NftAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Color backgroundColor;
  final bool automaticallyImplyLeading;

  const NftAppBar({
    super.key,
    required this.appBarTitle,
    this.backgroundColor = Colors.transparent,
    this.automaticallyImplyLeading = true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          appBarTitle,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        centerTitle: false,
        leading: visibleBackArrow(automaticallyImplyLeading, context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  Widget? visibleBackArrow(bool visible, BuildContext context){
    if(visible){
      return IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ));
    } else {
      null;
    }
  }
}

class NftButton extends StatelessWidget {
  final String textButton;
  final double width;
  final GestureTapCallback onPressed;

  const NftButton(
      {super.key,
      required this.textButton,
      required this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff999AAB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        minimumSize: Size(width, 48),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        textButton,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
