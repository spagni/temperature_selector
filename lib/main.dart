import 'package:flutter/material.dart';
import 'package:temperature_selector/main_screen.dart';

void main() => runApp(TemperatureApp());

class TemperatureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature App',
      home: MainScreen(),
    );
  }
}