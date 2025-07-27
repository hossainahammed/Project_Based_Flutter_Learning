import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    String output = "0";
    return Scaffold(
      appBar: AppBar(title: Text("Calculator"), backgroundColor: Colors.brown),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          Expanded(

            flex: 2,
            child: Column(
              children: [
                Expanded(

                  child: Row(
                    children: [
                      button("1"),
                      button("2"),
                      button("3"),
                      button("+"),
                    ],
                  ),
                ),

                Expanded(

                  child: Row(
                    children: [
                      button("4"),
                      button("5"),
                      button("6"),
                      button("-"),
                    ],
                  ),
                ),
                Expanded(

                  child: Row(
                    children: [
                      button("7"),
                      button("8"),
                      button("9"),
                      button("*"),
                    ],
                  ),
                ),
                Expanded(

                  child: Row(
                    children: [
                      button("0"),
                      button("C"),
                      button("#"),
                      button("/"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  button(String s) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => buttonPressed(s),
          child: Text(s, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
  buttonPressed(String s){}
}
