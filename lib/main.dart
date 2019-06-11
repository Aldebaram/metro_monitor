import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linhas do Metrô',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey),
      home: HomeScreen(),
    );
  }
}