import 'package:flutter/material.dart';
/// 消息页的 AppBar，有收起和弹出动画
class AutoAppBar extends StatefulWidget implements PreferredSizeWidget {
  AutoAppBar({
    Key key,
    this.controler,
    this.leftIcon,
    this.rightIcon,
    this.title: '',
    this.height: 48.0,
  }) : super(key: key);

  final Widget leftIcon;
  final Widget rightIcon;
  final String title;
  final double height;
  final AutoAppBarControler controler;

  @override
  _AutoAppBarState createState() => _AutoAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _AutoAppBarState extends State<AutoAppBar>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _controller;

  final String _backgroundImage = 'assets/app_bar.png';

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween(begin: 0.0, end: -1.0).animate(_controller);

    widget.controler?.animationController = _controller;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, _animation.value * 48.0),
      child: Stack(
        children: <Widget>[
          Image.asset(
            _backgroundImage,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).padding.top + 48.0,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 10.0,
                right: 10.0),
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: 1 + _animation.value,
                  child: widget.leftIcon ?? Container(),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withOpacity(1 + _animation.value)),
                ),
                Opacity(
                  opacity: 1 + _animation.value,
                  child: widget.rightIcon ?? Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 控制appBar的动画
class AutoAppBarControler {
  AnimationController animationController;

  void show() {
    animationController.reverse();
  }

  void hide() {
    animationController.forward();
  }
}
