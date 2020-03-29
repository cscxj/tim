import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/user_info_page/background_reveal.dart';
import 'package:flutter_tim/pages/user_info_page/my_info_item.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:flutter_tim/widgets/clip_trapezoid.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage>
    with TickerProviderStateMixin {
  ScrollController _scrollController;

  bool _isStick = true;
  Animation<double> _animation;
  AnimationController _animationController;
  Animation<double> _animation2;
  AnimationController _animationController2;
  Animation<double> _animation3;
  AnimationController _animationController3;
  Animation<Color> _animation4;
  AnimationController _animationController4;

  //List<Widget> _userInfoList;

  double _topExtend = .0; // 下拉时，头部拉长的偏移亮

  _initAnimation() {
    // 头部高度增加动画
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animation = Tween(begin: 200.0, end: 300.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();

    // 头部背景展开，内容上移，昵称下移动画
    _animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation2 = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController2, curve: Curves.easeInOutQuad))
      ..addListener(() {
        setState(() {});
      });
    _animationController2.forward();

    // AppBar 的背景和标题渐变动画
    _animationController3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animation3 = Tween(begin: .0, end: 1.0).animate(_animationController3)
      ..addListener(() {
        setState(() {});
      });
    // AppBar上的左右端文字颜色渐变
    _animationController4 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animation4 = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController4)
          ..addListener(() {
            setState(() {});
          });
  }

  // _initList() {
  //   _userInfoList = ;
  // }

  _initAppBar() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset < 0) {
          setState(() {
            _topExtend = -_scrollController.offset;
          });
        }
        bool exceed = _scrollController.offset < 60;
        if (_isStick != exceed) {
          // 防止频繁build
          if (_isStick) {
            _animationController3.forward();
            _animationController4.forward();
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ));
          } else {
            _animationController3.reverse();
            _animationController4.reverse();
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark));
          }

          setState(() {
            _isStick = exceed;
          });
        }
      });
  }

  @override
  void initState() {
    super.initState();
    _initAppBar();
    _initAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    _animationController4.dispose();
  }

  String getSex(num) {
    switch (num) {
      case 0:
        return '保密';
      case 1:
        return '男';
      case 2:
        return '女';
      default:
        return '未知';
    }
  }

  @override
  Widget build(BuildContext context) {
    UserState userState = Provider.of<UserState>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(_animation3.value),
          title: Text('个人资料',
              style: TextStyle(
                color: Colors.black.withOpacity(_animation3.value),
              )),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: UnconstrainedBox(
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/svg/tim_arrow_left.svg',
                    height: 20,
                    color: _animation4.value,
                  ),
                  Text(' 返回',
                      style:
                          TextStyle(fontSize: 16.0, color: _animation4.value))
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 14.0),
                alignment: Alignment.center,
                child: Text(
                  '更换头像',
                  style: TextStyle(color: _animation4.value, fontSize: 16.0),
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        controller: _scrollController,
        child: Transform.translate(
          offset:
              Offset(0, -_topExtend), // 页面下拉时，滑动视图超出多少，整个布局就上移多少，就好像没动的样子^_^
          child: Column(
            children: <Widget>[
              Stack(
                // 头部
                children: <Widget>[
                  Container(
                    height: _animation.value + _topExtend,
                    color: Colors.white, // 白色背景，填充梯形空缺部分
                    child: ClipTrapezoid(
                        //切割成梯形
                        child: Stack(
                      children: <Widget>[
                        BackgroundReveal(
                          // 有展开动画的背景
                          height: _animation.value + _topExtend,
                          background: Image.asset('assets/bg.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover),
                          child: LayoutBuilder(
                            builder: (_, constraints) {
                              return Image.asset(
                                userState.picture,
                                fit: BoxFit.cover,
                                height: constraints.maxHeight,
                                width: MediaQuery.of(context).size.width,
                              );
                            },
                          ),
                          initialPosition: Offset(
                              MediaQuery.of(context).size.width - 120.0, 100.0),
                          childSize: 110.0,
                          revealPercent: (1.0 - _animation2.value),
                        ),
                        Container(
                          // 图片上面的阴影渐变层
                          height: 300 + _topExtend,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(.0, -1.0),
                                  end: Alignment(.0, 1.0),
                                  colors: [
                                Colors.black.withOpacity(.5),
                                Colors.transparent,
                                Colors.black.withOpacity(.5),
                              ])),
                          child: Row(),
                        )
                      ],
                    )),
                  ),
                  Positioned(
                    bottom: 40.0 + _animation2.value * 100.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width / 2.0,
                      child: Text(
                        userState.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(top: _animation2.value * 200.0 + 30.0)),
              MyInfoItem(
                title: '账号',
                content: userState.username,
                extendLine: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/hehe.png'),
                    Text('慢速中',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff999999),
                            fontWeight: FontWeight.normal))
                  ],
                ),
              ),
              MyInfoItem(
                title: '个性签名',
                content: '哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈',
              ),
              MyInfoItem(title: '昵称', content: userState.name),
              MyInfoItem(title: '空间', content: '${userState.name}的空间'),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: FlatButton(
                      color: Colors.white,
                      onPressed: () {},
                      child: SizedBox(
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '更多资料',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                            ],
                          )))),
              MyInfoItem(title: '性别', content: getSex(userState.sex)),
              MyInfoItem(title: '生日', content: userState.birthday),
              MyInfoItem(title: '职业', content: userState.company),
              MyInfoItem(title: '公司', content: userState.company),
              MyInfoItem(title: '学校', content: userState.school),
              MyInfoItem(title: '地址', content: userState.address),
              MyInfoItem(title: '故乡', content: userState.hometown),
              MyInfoItem(
                title: '邮箱',
                content: userState.email,
                hasUnderLine: false,
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 25.0))
            ],
          ),
        ),
      ),
    );
  }
}
