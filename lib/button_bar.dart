import 'package:flutter/material.dart';

class CustomButtonBar extends StatefulWidget {
  @override
  _CustomButtonBarState createState() => _CustomButtonBarState();
}

class _CustomButtonBarState extends State<CustomButtonBar> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: FittedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildIconButton(Icons.keyboard, 0),
                  _buildIconButton(Icons.pages, 1),
                  _buildIconButton(Icons.offline_bolt, 2),
                  _buildIconButton(Icons.radio, 3),
                  _buildIconButton(Icons.edit,  4),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: AnimatedContainer(
                      alignment: Alignment(_getAlignment(), 0.0),
                      duration: Duration(milliseconds: 300),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 5.0,
                        width: (MediaQuery.of(context).size.width) * .2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: (index == _currentIndex) ? Colors.white : Colors.white70,
      ),
      iconSize: 35.0,
      onPressed: (_currentIndex == index)
          ? null
          : () {
              setState(() => _currentIndex = index);
            },
    );
  }

  double _getAlignment() {
    switch(_currentIndex) {
      case 0: 
        return -1.0;
      case 1: 
        return -0.5;
      case 2: 
        return 0.0;
      case 3: 
        return 0.5;
      case 4: 
        return 1.0;
      default:
        return 0.0;
    }
  }
}
