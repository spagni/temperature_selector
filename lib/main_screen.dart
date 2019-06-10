import 'package:flutter/material.dart';
import 'package:temperature_selector/button_bar.dart';
import 'package:temperature_selector/selector.dart';
import 'package:temperature_selector/styles.dart';

import 'custom_appbar.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.mediumBlue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'TEMPERATURE',
              icon: Icons.arrow_back,
              mainColor: Colors.white70,
            ),
            SizedBox(height: 12.0),
            CustomButtonBar(),
            SizedBox(height: 12.0),
            TemperatureSelector(),
          ],
        ),
      ),
    );
  }
}