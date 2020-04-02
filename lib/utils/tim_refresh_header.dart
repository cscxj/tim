import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class TimRefreshHeader extends Header {
  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    double angle = refreshState == RefreshMode.drag ? pulledExtent * 6 : .0;

    return _TimRefreshHeaderWidget(
      angle: angle,
      state: refreshState,
    );
  }
}

class _TimRefreshHeaderWidget extends StatefulWidget {
  /// 旋转角度 取值在 0 - 360
  ///
  final double angle;

  final RefreshMode state;
  const _TimRefreshHeaderWidget({Key key, this.angle: .0, this.state})
      : super(key: key);
  @override
  _TimRefreshHeaderWidgetState createState() => _TimRefreshHeaderWidgetState();
}

class _TimRefreshHeaderWidgetState extends State<_TimRefreshHeaderWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..addListener(() {
            if (_animationController.value != 0) {
              setState(() {});
            }
          });
    _animation = Tween(begin: .0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state == RefreshMode.armed) {
      _animationController.forward();
    } else if (widget.state == RefreshMode.inactive &&
        _animation.status == AnimationStatus.completed) {
      _animationController.reset();
    }

    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              bottom: 10.0,
              child: TimIndicator(
                size: 16 + _animation.value * 4,
                hollowRadius: 5 - 5 * _animation.value,
                lineWidth: 3 + _animation.value * 1.5,
                rotate: widget.angle + _animation.value * -720.0,
              ))
        ],
      ),
    );
  }
}

class TimIndicator extends StatelessWidget {
  /// 旋转角度 0 ~ 360
  final double rotate;

  /// 大小
  final double size;

  /// 空心半径,必须小于 size * 1/2
  final double hollowRadius;

  /// 线条大小
  final double lineWidth;

  /// 颜色
  final Color color;

  const TimIndicator(
      {Key key,
      this.rotate: 0.0,
      this.size: 60.0,
      this.hollowRadius: 20,
      this.lineWidth: 10.0,
      this.color: Colors.grey})
      : assert(hollowRadius <= size / 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        height: size,
        width: size,
        child: CustomPaint(
          painter:
              TimIndicatorPainter(rotate, size, hollowRadius, lineWidth, color),
        ),
      ),
    );
  }
}

class TimIndicatorPainter extends CustomPainter {
  /// 旋转角度 0 ~ 360
  final double rotate;

  /// 大小
  final double size;

  /// 空心半径,必须小于 size * 1/2
  final double hollowRadius;

  /// 线条大小
  final double lineWidth;

  /// 颜色
  final Color color;

  TimIndicatorPainter(
      this.rotate, this.size, this.hollowRadius, this.lineWidth, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double r = min(size.height, size.width) / 2;
    canvas.translate(r, r);
    canvas.rotate(rotate * pi / 180.0);

    Offset ip1 = Offset.fromDirection(54.0 * pi / 180.0, hollowRadius);
    Offset ip2 = Offset.fromDirection(126.0 * pi / 180.0, hollowRadius);
    Offset ip3 = Offset.fromDirection(198.0 * pi / 180.0, hollowRadius);
    Offset ip4 = Offset.fromDirection(270.0 * pi / 180.0, hollowRadius);
    Offset ip5 = Offset.fromDirection(342.0 * pi / 180.0, hollowRadius);

    Offset op1 = Offset.fromDirection(54.0 * pi / 180.0, r);
    Offset op2 = Offset.fromDirection(126.0 * pi / 180.0, r);
    Offset op3 = Offset.fromDirection(198.0 * pi / 180.0, r);
    Offset op4 = Offset.fromDirection(270.0 * pi / 180.0, r);
    Offset op5 = Offset.fromDirection(342.0 * pi / 180.0, r);

    Paint paint = Paint()
      ..color = color
      ..strokeWidth = lineWidth;

    canvas.drawLine(ip1, op1, paint);
    canvas.drawLine(ip2, op2, paint);
    canvas.drawLine(ip3, op3, paint);
    canvas.drawLine(ip4, op4, paint);
    canvas.drawLine(ip5, op5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
