import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tim/api/api.dart';
import 'package:flutter_tim/pages/home_page.dart';
import 'package:flutter_tim/pages/register_page.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:flutter_tim/utils/keyboard_detector.dart';
import 'package:flutter_tim/widgets/enter_exit_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as cv;

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _translateAnimation;
  Animation<double> _rotateAnimation;
  Animation<double> _picureFrameAnimation;
  Animation<double> _welcomeTextAnimaion;
  Animation<double> _formEnterAnimation;

  AnimationController _fadeInAnimationController;
  Animation<double> _fadeInAnimation;

  AnimationController _pictureScaleAnimationContorller;
  Animation _pictureScaleAnimation;

  TextEditingController _userInputController;
  TextEditingController _pwdInputController;
  Dio _dio;

  bool _keyBoardShow = false;

  Widget getLinkText(
    String text, {
    size: 14.0,
    Function onPress,
  }) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.blue, fontSize: size),
          )),
    );
  }

  Widget getInputBox(
      {@required String hintText,
      @required TextInputType inputType,
      TextEditingController controller,
      bool hideText: false}) {
    return Container(
      //color: Colors.pink,
      width: 200.0,
      height: 50.0,
      child: TextField(
        controller: controller ?? TextEditingController(),
        keyboardType: inputType,
        cursorColor: Color(0xff666666),
        cursorWidth: .5,
        scrollPadding: EdgeInsets.all(0),
        style: TextStyle(
            //fontSize: 20.0
            ),
        obscureText: hideText,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 18.0),
            border: InputBorder.none),
      ),
    );
  }

  // 登录按钮逻辑
  signIn(UserState state) async {
    if (_welcomeTextAnimaion.status == AnimationStatus.completed) {
      if (_userInputController.text.isEmpty ||
          _pwdInputController.text.isEmpty) {
        Fluttertoast.showToast(msg: '用户名和密码不能为空！');
        return;
      }

      Navigator.pushAndRemoveUntil(context,
          new PageRouteBuilder(pageBuilder: (_, anim1, anim2) {
        return FadeTransition(
          opacity: anim1,
          child: HomePage(),
        );
      }), (route) => route == null);
      // Response<String> response = await _dio.post(Api.login, queryParameters: {
      //   'username': _userInputController.text,
      //   'password': _pwdInputController.text
      // });
      // Map<String, dynamic> data = cv.jsonDecode(response.data);

      // if (data['result']) {
      //   print(data['data']);
      //   Map user = data['data'];
      //   state.update(
      //       username: user['id'].toString(),
      //       name: user['name'],
      //       grade: user['grade'],
      //       phone: user['phone'],
      //       email: user['email'],
      //       sex: int.parse(user['sex']),
      //       birthday: user['birthday'],
      //       address: user['address'],
      //       hometown: user['hometown'],
      //       school: user['school'],
      //       company: user['company'],
      //       picture: user['picture']);
      //   Navigator.push(context, CupertinoPageRoute(builder: (_) {
      //     return HomePage();
      //   }));
      // } else {
      //   Fluttertoast.showToast(msg: data['msg']);
      // }
    } else if (_welcomeTextAnimaion.status != AnimationStatus.forward) {
      // 动画正在执行时不能触发
      _animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200))
          ..addListener(() {
            setState(() {});
          });
    _translateAnimation = Tween(begin: .0, end: .5).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(.0, 1.0, curve: Curves.easeOutCubic)));
    _rotateAnimation = Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(.0, 1.0, curve: Curves.easeInOutCubic),
    ));
    _picureFrameAnimation = Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(.5, 1.0, curve: Curves.easeOutQuart)));
    _welcomeTextAnimaion = Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(.0, .5, curve: Curves.linear),
    ));
    _formEnterAnimation = Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(.5, 1.0, curve: Curves.linear),
    ));

    _fadeInAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _fadeInAnimation = Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
        parent: _fadeInAnimationController, curve: Curves.linear));

    _pictureScaleAnimationContorller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _pictureScaleAnimation = Tween<double>(begin: 1.0, end: .8).animate(
        CurvedAnimation(
            parent: _pictureScaleAnimationContorller,
            curve: Curves.easeInCubic));

    _fadeInAnimationController.forward();

    _userInputController = TextEditingController(text: '1000000');
    _pwdInputController = TextEditingController(text: '12345678');

    _dio = Dio();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _fadeInAnimationController.dispose();
    _pictureScaleAnimationContorller.dispose();
    _userInputController.dispose();
    _pwdInputController.dispose();
    // _focusNode.dispose();
  }

  @override
  void didUpdateWidget(LoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDetector(
        keyboardShowCallback: (isShow) {
          if (isShow &&
              _pictureScaleAnimation.status != AnimationStatus.forward) {
            _pictureScaleAnimationContorller.forward();
          } else if (!isShow &&
              _pictureScaleAnimation.status != AnimationStatus.reverse) {
            _pictureScaleAnimationContorller.reverse();
          }
          setState(() {
            _keyBoardShow = isShow;
          });
        },
        content: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(
              children: <Widget>[
                CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: _BackgroundPainter(
                      translate: this._translateAnimation,
                      rotate: this._rotateAnimation),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 120,
                    ),
                    PictureFrame(
                      toggleValue: _picureFrameAnimation,
                      scaleValue: _pictureScaleAnimation,
                    ),
                    Expanded(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Transform.translate(
                            offset: Offset(
                                0.0, _fadeInAnimation.value * 20.0 - 20.0),
                            child: FadeTransition(
                                opacity: _fadeInAnimation,
                                child: Container(
                                  height: 134.0 - (_keyBoardShow ? 34.0 : .0),
                                  child: Stack(
                                    children: <Widget>[
                                      Transform.translate(
                                        offset: Offset(
                                            .0,
                                            40.0 * _fadeInAnimation.value -
                                                40.0),
                                        child: FadeTransition(
                                          opacity: _formEnterAnimation,
                                          // 欢迎文字动画执行完毕之后显示文本框
                                          child: _welcomeTextAnimaion.value ==
                                                  1.0
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    getInputBox(
                                                        controller:
                                                            _userInputController,
                                                        hintText: 'QQ号/手机/邮箱',
                                                        inputType: TextInputType
                                                            .number),
                                                    Container(
                                                      width: 200.0,
                                                      child: Divider(
                                                        height: .0,
                                                        thickness: .3,
                                                        color: Colors.black45
                                                            .withOpacity(.2),
                                                      ),
                                                    ),
                                                    getInputBox(
                                                        controller:
                                                            _pwdInputController,
                                                        hideText: true,
                                                        hintText: '密码',
                                                        inputType: TextInputType
                                                            .visiblePassword),
                                                  ],
                                                )
                                              : UnconstrainedBox(),
                                        ),
                                      ),
                                      ClipRect(
                                        clipper: WelcomTextCliper(
                                            _welcomeTextAnimaion),
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: <Widget>[
                                            Text('欢迎来到TIM',
                                                style: TextStyle(
                                                  fontSize: 36.0,
                                                  color: Colors.black
                                                      .withOpacity(1.0 -
                                                          _welcomeTextAnimaion
                                                              .value),
                                                )),
                                            Text('让    工    作    更    高    效',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black38))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Container(
                            width: 30.0 +
                                _fadeInAnimation.value * 30.0 +
                                140.0 * _formEnterAnimation.value,
                            child: Divider(
                                height: .0,
                                thickness: 1.0 - _formEnterAnimation.value * .7,
                                color: Colors.black45.withOpacity(
                                    1.0 - _formEnterAnimation.value * .8)),
                          ),
                          Container(
                            height: 50.0 - (_keyBoardShow ? 25 : 0),
                          ),
                          Opacity(
                              opacity:
                                  (.5 - _welcomeTextAnimaion.value).abs() * 2,
                              child: Transform.translate(
                                offset: Offset(
                                    0.0, 20.0 - _fadeInAnimation.value * 20.0),
                                child: FadeTransition(
                                    opacity: _fadeInAnimation,
                                    child: Column(
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            signIn(Provider.of<UserState>(
                                                context,
                                                listen: false));
                                          },
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 80.0, vertical: 12.0),
                                          child: Text(
                                            '登 录',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                          ),
                                          color: Color(0xff2295ff),
                                        ),
                                        _welcomeTextAnimaion.value < .5
                                            ? getLinkText('使用QQ一键登录',
                                                size: 12.0)
                                            : Container(
                                                padding: EdgeInsets.all(10.0),
                                                width: 224,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(3.0),
                                                      child: Icon(
                                                        Icons.check,
                                                        size: 12.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      child: RichText(
                                                          text: TextSpan(
                                                              text: '接受',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      12.0),
                                                              children: [
                                                            TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                                text: '服务条款'),
                                                            TextSpan(
                                                                text:
                                                                    '并同意同步该QQ号的账号、好友等聊天信息。')
                                                          ])),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                      ],
                                    )),
                              )),
                        ],
                      ),
                    )),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Opacity(
                            opacity: (.5 - _formEnterAnimation.value).abs() * 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                getLinkText('新用户注册', onPress: () {
                                  Navigator.push(
                                      context,
                                      EnterExitRoute(
                                          exitPage: widget,
                                          enterPage: RegisterPage()));
                                }),
                                _formEnterAnimation.value < .5
                                    ? getLinkText('了解TIM')
                                    : getLinkText('无法登录?')
                              ],
                            ),
                          ),
                          Container(
                              height: 30.0 * _formEnterAnimation.value,
                              color: Color(0xffefefef))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

class _BackgroundPainter extends CustomPainter {
  Paint _backgroundPaint;
  Paint _forefroundPaint;
  final Animation<double> translate;
  final Animation<double> rotate;

  _BackgroundPainter({@required this.rotate, @required this.translate}) {
    _backgroundPaint = Paint()..color = Colors.blue[900];
    _forefroundPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect bgArea = Rect.fromLTWH(.0, .0, size.width, size.height);
    // 高度足够大
    Rect viewArea = Rect.fromCenter(
        center: Offset(.0, .0), width: size.width, height: 10000);
    // 绘制深蓝色背景
    canvas.drawRect(bgArea, _backgroundPaint);
    canvas.save();
    //画布初始角度
    canvas.rotate(-47.5 * pi / 180.0);
    // 因为旋转的转心是画布的左上角，所以要改变旋转中心，就要把自己想要的中心点位置绘制在画布的左上角
    canvas.translate(size.width / 2, size.height / 5);
    // 根据动画改变
    canvas.translate(-this.translate.value * size.width, .0);
    canvas.rotate(this.rotate.value * 100 * pi / 180);
    canvas.drawRect(viewArea, _forefroundPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// 头像框
class PictureFrame extends StatefulWidget {
  final double height;
  final double imageSize;
  final String imagePath;
  final Animation<double> toggleValue;
  final Animation<double> scaleValue;

  const PictureFrame(
      {Key key,
      this.height: 140.0,
      this.imageSize: 120.0,
      this.imagePath: 'assets/touXiang.jpg',
      @required this.toggleValue,
      this.scaleValue})
      : super(key: key);

  @override
  _PictureFrameState createState() => _PictureFrameState();
}

class _PictureFrameState extends State<PictureFrame>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: PictureFrameCliper(widget.toggleValue),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: widget.height,
              color: Colors.white,
            ),
          ),
          Center(
            child: Transform.translate(
                offset: Offset(.0, widget.toggleValue.value * 20.0 - 20),
                child: FadeTransition(
                  opacity: widget.toggleValue,
                  child: ScaleTransition(
                      scale: widget.scaleValue,
                      child: Container(
                        decoration: ShapeDecoration(
                            shape: CircleBorder(
                              side: BorderSide(
                                width: 3.0,
                                color: Colors.white.withOpacity(.3),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 3.0,
                                  offset: Offset(.0, 3.0))
                            ]),
                        child: ClipOval(
                          child: Image.asset(widget.imagePath,
                              width: widget.imageSize),
                        ),
                      )),
                )),
          )
        ],
      ),
    );
  }
}

class PictureFrameCliper extends CustomClipper<Path> {
  final Animation _animation;

  PictureFrameCliper(this._animation);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * _animation.value);
    path.lineTo(0, size.height * (1.0 - _animation.value));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WelcomTextCliper extends CustomClipper<Rect> {
  final Animation<double> _anitmation;

  WelcomTextCliper(this._anitmation);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
        0.0, 0.0, size.width, size.height - size.height * _anitmation.value);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
