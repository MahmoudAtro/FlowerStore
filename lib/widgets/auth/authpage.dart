import 'package:flutter/material.dart';
import 'package:storeapp/shared/color.dart';

// ignore: must_be_immutable
class AuthPage extends StatelessWidget {
  AuthPage({super.key, required this.title, required this.body});
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar( 
        title: Text(title , style: TextStyle(
          color: Colors.white, fontSize: 20,
        ),),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appbarGreen,
      ),
      body: body,
    ));
  }
}