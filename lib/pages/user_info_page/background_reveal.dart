import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundReveal extends StatelessWidget {
  final double revealPercent; //初始百分比
  final Widget background; // 背景
  final Widget child; // 圆圈中的孩子
  final Offset initialPosition; //圆心初始位置
  final double height; // 高度
  final double childSize; //子控件大小

  BackgroundReveal(
      {Key key,
      this.revealPercent: .2,
      @required this.child,
      @required this.background,
      this.height,
      @required this.initialPosition,
      @required this.childSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Stack(
            children: <Widget>[
              background ?? Container(),
              Container(
                child: ClipOval(
                    clipper: CircleRevealClipper(
                        revealPercent, initialPosition, childSize),
                    child: child ?? Container()),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  final double childSize;
  final double revealPercent;
  Offset position;

  CircleRevealClipper(this.revealPercent, this.position, this.childSize);

  @override
  Rect getClip(Size size) {
    // 最大圆的中心，也就是整个组件的中心
    final maxCircleCenter = new Offset(size.width / 2, size.height / 2); 
    final maxRadius =
        sqrt(maxCircleCenter.dx * maxCircleCenter.dx + maxCircleCenter.dy * maxCircleCenter.dy);
    //当前半径
    double currentRadius = (maxRadius - childSize / 2) * revealPercent + childSize / 2; 
    //当前中心  坐标
    double currentDx = position.dx + childSize / 2;
    double currentDy = position.dy + childSize / 2;
    // 相距最终圆的距离
    double l = maxCircleCenter.dx - currentDx;
    double w = maxCircleCenter.dy - currentDy;
    // 圆心向中点移动
    double dx = currentDx + l * revealPercent;
    double dy = currentDy + w * revealPercent;
    return Rect.fromCircle(
        center: Offset(dx, dy), radius: currentRadius);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
