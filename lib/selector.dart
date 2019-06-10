import 'package:flutter/material.dart';
import 'package:temperature_selector/circle_selector.dart';

class TemperatureSelector extends StatefulWidget {
  @override
  _TemperatureSelectorState createState() => _TemperatureSelectorState();
}

class _TemperatureSelectorState extends State<TemperatureSelector> with SingleTickerProviderStateMixin{
  int _selectedValue;
  TextStyle get _smallTextStyle => TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
        letterSpacing: -1.0,
        fontWeight: FontWeight.w200,
      );

  @override
  void initState() {
    super.initState();
    _selectedValue = 23;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildNumbersRow(),
        _buildSelectOptions(),
        SizedBox(height: 24.0),
        _buildSelector(),
      ],
    );
  }

  Widget _buildSelectOptions() {
    return FittedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildOption(10),
              _buildOption(15),
              _buildOption(20),
              _buildOption(25),
              _buildOption(30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int number) {
    return Column(
      children: <Widget>[
        Text(
          '$number',
          style: _smallTextStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          width: 1.0,
          height: 15.0,
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildSelector() {
    return FittedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: CircleSelector(
          minValue: 10,
          maxValue: 30,
          initialValue: 23,
          onChange: (int value) async {
            setState(() => _selectedValue = value);
          },
        ),
      ),
    );
  }

  Widget _buildNumbersRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '18\nCurrent',
            textAlign: TextAlign.center,
            style: _smallTextStyle,
          ),
          Text(
            '$_selectedValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 150.0,
              color: Colors.white,
              letterSpacing: -15.0,
            ),
          ),
          Text(
            '50%\nHumidity',
            textAlign: TextAlign.center,
            style: _smallTextStyle,
          ),
        ],
      ),
    );
  }
}