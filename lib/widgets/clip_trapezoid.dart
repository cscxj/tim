import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClipTrapezoid extends StatelessWidget {
  ClipTrapezoid({
    Key key,
    @required this.child,
    this.height
  }):super(key:key);

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TrapezoidClipper(height: height),
      child: child,
    );
  }
}

class _TrapezoidClipper extends CustomClipper<Path> {
  _TrapezoidClipper({@required this.height});

  double height;

  @override
  getClip(Size size) {
    height = height??size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, height);
    path.lineTo(size.width, height - 60);
    path.lineTo(size.width,0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}