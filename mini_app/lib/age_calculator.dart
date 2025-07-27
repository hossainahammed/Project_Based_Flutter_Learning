import 'package:flutter/material.dart';

class AgeCalculator extends StatefulWidget {
  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  final _dobController = TextEditingController();
  String _age = '';

  void _calculateAge() {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateTime.parse(_dobController.text);
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    setState(() {
      _age = 'Your Age is: $age';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(labelText: 'Enter Date of Birth (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAge,
              child: const Text('Calculate Age'),
            ),
            const SizedBox(height: 20),
            if (_age.isNotEmpty)
              Text(
                _age,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
