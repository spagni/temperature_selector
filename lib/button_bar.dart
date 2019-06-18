import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomButtonBar extends StatefulWidget {
  @override
  _CustomButtonBarState createState() => _CustomButtonBarState();
}

class _CustomButtonBarState extends State<CustomButtonBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _alignAnim;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 2;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _alignAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  _buildIconButton(Icons.edit, 4),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _alignAnim,
                    builder: (BuildContext context, _) {
                      double gauss = math
                          .exp(-(math.pow((_controller.value - .5), 8) / .02));
                      double width =
                          (MediaQuery.of(context).size.width) * .25 * gauss;

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          alignment: Alignment(_alignAnim.value, 0.0),
                          child: Container(
                            height: 5.0,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      );
                    },
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
              _alignAnim = Tween(
                      begin: _getAlignment(_currentIndex),
                      end: _getAlignment(index))
                  .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeIn,
                ),
              );
              _controller.reset();
              _controller.forward();

              setState(() => _currentIndex = index);
            },
    );
  }

  double _getAlignment(int index) {
    switch (index) {
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
