import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:temperature_selector/styles.dart';

class CircleSelector extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final Function(int) onChange;

  CircleSelector({
    @required this.minValue,
    @required this.maxValue,
    @required this.initialValue,
    @required this.onChange,
  })  : assert(minValue != null),
        assert(maxValue != null),
        assert(minValue <= initialValue && initialValue <= maxValue);

  @override
  _CircleSelectorState createState() => _CircleSelectorState();
}

class _CircleSelectorState extends State<CircleSelector>
    with SingleTickerProviderStateMixin {
  double get _selectorSize => 80.0;
  double get _maxWidth => MediaQuery.of(context).size.width - _selectorSize;
  int get _maxDelta => widget.maxValue - widget.minValue;
  double _circleOffset;
  double _animateToOffset;
  AnimationController _controller;

  double _calculateOffset(int value) {
    return (value - widget.minValue) * _maxWidth / _maxDelta;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _circleOffset = _animateToOffset;
        }
      })
      ..addListener(() {
        widget.onChange(_getNumberFromPosition(_getAnimatedPosition()));
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted)
        setState(() {
          _circleOffset = _calculateOffset(widget.initialValue);
        });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            right: 0.0,
            bottom: 0.0,
            left: 0.0,
            child: Center(
              child: GestureDetector(
                onTapDown: _onTapDown,
                onHorizontalDragUpdate: _onHorizontalDragUpdate,
                // Agrego el container transparente para que el hitTest tenga un tamaño mayor
                // En el container de height 1 era imposible hacer el tap
                child: Container(
                  height: 40.0,
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 3.0,
                      color: Styles.darkBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Positioned(
                top: 0.0,
                left: (!_controller.isAnimating)
                    ? _circleOffset
                    : _getAnimatedPosition(),
                bottom: 0.0,
                child: child,
              );
            },
            child: Center(
              child: GestureDetector(
                onHorizontalDragUpdate: _onHorizontalDragUpdate,
                child: Container(
                  height: _selectorSize,
                  width: _selectorSize,
                  decoration: BoxDecoration(
                    color: Styles.darkBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.code, size: 40.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (mounted)
      setState(
        () {
          _circleOffset = (details.globalPosition.dx - _selectorSize / 2)
              .clamp(0.0, _maxWidth);
        },
      );

    widget.onChange(_getNumberFromPosition(_circleOffset));
  }

  void _onTapDown(TapDownDetails details) {
    _animateToOffset =
        (details.globalPosition.dx - _selectorSize / 2.0).clamp(0.0, _maxWidth);

    _controller.reset();
    _controller.fling();

    widget.onChange(_getNumberFromPosition(_animateToOffset));
  }

  int _getNumberFromPosition(double position) {
    int _value = (position * _maxDelta / _maxWidth).round();
    return _value + widget.minValue;
  }

  double _getAnimatedPosition() {
    return lerpDouble(
      _circleOffset,
      _animateToOffset,
      _controller.value,
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final double position;

  MyCustomPainter({
    this.position,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Styles.darkBlue;
    Path path = Path();

    double maxHeight = size.height / 2;
    path.lineTo(0.0, maxHeight);
    path.lineTo(size.width / 2 - 70.0, maxHeight);
    path.quadraticBezierTo(size.width / 2 - 60.0, maxHeight,
        size.width / 2 - 50.0, maxHeight - 10.0);
    path.quadraticBezierTo(
        size.width / 2, -20.0, size.width / 2 + 60.0, maxHeight - 10.0);
    path.quadraticBezierTo(
        size.width / 2 + 70, maxHeight, size.width / 2 + 80.0, maxHeight);
    path.lineTo(size.width, maxHeight);
    path.lineTo(size.width, 0.0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
