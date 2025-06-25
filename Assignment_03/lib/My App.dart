import 'package:flutter/material.dart';
import 'API_WOrk.dart';
import 'main.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'API CRUD',

        home:ApiWork());






  }
}