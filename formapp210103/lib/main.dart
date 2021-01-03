import 'package:flutter/material.dart';
import 'package:formapp210103/Pages/formPage.dart';

void main() {
  runApp(FormApp());
}

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormPage()
    );
  }
}
