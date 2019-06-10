import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color mainColor;

  CustomAppBar({
    @required this.title,
    this.icon,
    this.mainColor = Colors.white,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white30,
            ),
            child: IconButton(
              icon: Icon(
                icon,
                color: mainColor
              ),
              iconSize: 40.0,
              onPressed: () {},
            ),
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: mainColor,
                fontSize: 20.0,
                letterSpacing: -1.0,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}