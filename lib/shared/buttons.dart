import 'package:flutter/material.dart';
import 'package:storeapp/shared/color.dart';

class Btn extends StatelessWidget {
  Btn(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.isregister});
  final String child;
  final Function() onPressed;
  final bool isregister;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: BTNgreen,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: isregister
            ? Text(
                child,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            : CircularProgressIndicator(
                color: Colors.white,
              ));
  }
}
