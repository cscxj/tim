import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/user_info_page/my_info_item.dart';

class FriendInfoPage extends StatefulWidget {
  @override
  _FriendInfoPageState createState() => _FriendInfoPageState();
}

class _FriendInfoPageState extends State<FriendInfoPage>
    with TickerProviderStateMixin {
  ScrollController _bodyScrollController;

  double _pullExtend = 0;

  Animation<double> _appBarAnimation;
  Animation<Color> _colorAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400))
          ..addListener(() {
            setState(() {});
          });
    _appBarAnimation = Tween(begin: .0, end: 1.0).animate(_animationController);
    _colorAnimation =
        ColorTween(begin: Color(0xffffffff), end: Color(0xff000000))
            .animate(_animationController);
    bool overflow = false;
    _bodyScrollController = ScrollController()
      ..addListener(() {
        if (_bodyScrollController.offset < 0) {
          setState(() {
            _pullExtend = _bodyScrollController.offset;
          });
        }
        if (!overflow && _bodyScrollController.offset > 60) {
          _animationController.forward();
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        } else if (overflow && _bodyScrollController.offset < 60) {
          _animationController.reverse();
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        }
        overflow = _bodyScrollController.offset > 60;
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bodyScrollController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          backgroundColor: Colors.white.withOpacity(_appBarAnimation.value),
          elevation: .0,
          centerTitle: true,
          title: Text(
            '个人资料',
            style: TextStyle(
                color: Colors.black.withOpacity(_appBarAnimation.value)),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: SvgPicture.asset(
                'assets/svg/tim_arrow_left.svg',
                color: _colorAnimation.value,
                height: 36.0,
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: Text(
                '更多   ',
                style: TextStyle(fontSize: 18.0, color: _colorAnimation.value),
              ),
            )
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        controller: _bodyScrollController,
        child: Transform.translate(
          offset: Offset(.0, _pullExtend),
          child: Column(children: <Widget>[
            Container(
              child: Container(
                height: 260.0 - _pullExtend,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/touXiang.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            MyInfoItem(title: 'TIM账号', content: '927223795'),
            MyInfoItem(title: '昵称', content: '问东问西'),
            MyInfoItem(title: '空间', content: '问东问西的空间'),
            MyInfoItem(title: '分组', content: '1701'),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            MyInfoItem(title: '备注名', content: '斯洛伐克就'),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Text(
                      '添加更多备注信息',
                      style: TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                  ],
                )),
            MyInfoItem(title: '生日', content: '6月30日'),
            MyInfoItem(title: '职业', content: '前端攻城狮'),
            MyInfoItem(title: '公司', content: 'Google'),
            MyInfoItem(
              title: '故乡',
              content: '梵蒂冈',
              hasUnderLine: false,
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        height: 48.0,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          '发消息',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }
}
