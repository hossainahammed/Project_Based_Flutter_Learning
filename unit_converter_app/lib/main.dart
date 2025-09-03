import 'package:flutter/material.dart';
import 'package:unit_converter_app/presentation/ui/screens/home_screen.dart';

void main() {
  runApp(UnitConverter());
}
class UnitConverter extends StatelessWidget {
  const UnitConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}






