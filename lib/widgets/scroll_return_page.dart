import 'package:flutter/material.dart';

class ScrollReturnPage extends StatelessWidget {
  final Widget child;

  const ScrollReturnPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (d) {
        if (d.velocity.pixelsPerSecond.dx > 0) {
          Navigator.maybePop(context);
        }
      },
      child: child,
    );
  }
}
