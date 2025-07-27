import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  static final List<String> _bmiHistory = [];

  static void addBMIResult(String result) {
    _bmiHistory.add(result);
  }

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI History')),
      body: ListView.builder(
        itemCount: HistoryScreen._bmiHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(HistoryScreen._bmiHistory[index]),
            tileColor: Colors.amberAccent,
          );
        },
      ),
    );
  }
}
