import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tim/api/api.dart';
import 'package:flutter_tim/widgets/tim_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegExp _emailRe = RegExp(
      r'^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$');
  bool _inputCorrect = false;

  TextEditingController _inputController;
  FocusNode _emailInputNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inputController = TextEditingController();

    _emailInputNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailInputNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: .0,
      ),
      body: Column(
        children: <Widget>[
          CustomPaint(
            painter: AppBarGgPainter(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 260.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60.0,
                        ),
                        TextField(
                          focusNode: _emailInputNode,
                          controller: _inputController,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.grey,
                          style: TextStyle(fontSize: 30.0),
                          cursorWidth: .5,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (text) {
                            setState(() {
                              _inputCorrect =
                                  _emailRe.hasMatch(text) ? true : false;
                            });
                          },
                          decoration: InputDecoration(
                              //errorText: _errorText,
                              hintText: '输入您的邮箱',
                              hintStyle:
                                  TextStyle(fontSize: 30.0, color: Colors.grey),
                              border: InputBorder.none),
                        ),
                        Divider(
                          height: 0,
                          thickness: .5,
                        ),
                        Container(
                          height: 60.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (_inputCorrect) {
                                  _emailInputNode.unfocus();
                                Dio().post(Api.register,queryParameters: {
                                  'email_address':_inputController.text
                                }).then((value){
                                  print(value);
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return TimDialog(
                                        contentView: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '已发送邮件到您的邮箱，点击邮件中的链接完成注册，请注意查收!',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        bottomView: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            color: Colors.blue[900],
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 8),
                                            child: Text(
                                              '确定',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                } else {
                                  Fluttertoast.showToast(msg: '邮箱格式不正确！');
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                size: 40.0,
                                color:
                                    _inputCorrect ? Colors.blue : Colors.grey,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Wrap(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 2),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                    size: 12.0,
                                  )),
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.0),
                                      children: [
                                    TextSpan(text: '我已阅读并同意'),
                                    TextSpan(
                                        style: TextStyle(color: Colors.blue),
                                        text: '使用条款'),
                                    TextSpan(text: '和'),
                                    TextSpan(
                                        style: TextStyle(color: Colors.blue),
                                        text: '隐私政策'),
                                  ]))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarGgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint darkPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    final Paint lightPaint = Paint()..color = Colors.blue[900];
    final Paint whitePaint = Paint()..color = Colors.white;

    Path path1 = Path()
      ..moveTo(.0, .0)
      ..lineTo(.0, size.height * 1.5)
      ..lineTo(size.height * 1.2, .0)
      ..close();
    Path path2 = Path()
      ..moveTo(.0, size.height * 7 / 10)
      ..lineTo(.0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), lightPaint);
    canvas.drawPath(path1, darkPaint);
    canvas.drawPath(path2, whitePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
