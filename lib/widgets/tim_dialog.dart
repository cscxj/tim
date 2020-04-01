import 'package:flutter/material.dart';

class TimDialog extends StatefulWidget {
  final Widget contentView;
  final Widget bottomView;

  const TimDialog({Key key, this.contentView, this.bottomView})
      : super(key: key);

  @override
  _TimDialogState createState() => _TimDialogState();
}

class _TimDialogState extends State<TimDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.blue[900],
      child: CustomPaint(
        painter: DialogBgPainter(),
        child: Container(
          margin: EdgeInsets.only(top: 20),
          height: 180,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: widget.contentView ?? Container(),
              ),
              widget.bottomView ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}

class DialogBgPainter extends CustomPainter {
  final Color color;

  DialogBgPainter({this.color: Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 3, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
