import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Combinational app',
      theme: ThemeData(
        primarySwatch: Colors.blue,


      ),
      home: HomeScreen(),
    );
  }
}
