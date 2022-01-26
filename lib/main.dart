import 'package:flutter/material.dart';
import './randomWords.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: RandomWordGenerator());
  }
}
