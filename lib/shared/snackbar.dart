import 'package:flutter/material.dart';

showSnackBar(context , text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}