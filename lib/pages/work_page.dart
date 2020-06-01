import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/setting_page.dart';
import 'package:flutter_tim/pages/user_info_page.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:flutter_tim/widgets/clip_trapezoid.dart';
import 'package:flutter_tim/widgets/enter_exit_route.dart';
import 'package:provider/provider.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  Widget getToolListItem({String image, String title}) {
    return MaterialButton(
      onPressed: () {},
      child: Column(
        children: <Widget>[
          Container(
            height: 48,
            child: Row(
              children: <Widget>[
                Image.asset(
                  image ?? 'assets/email.png',
                  width: 20,
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(title ?? '邮箱'),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
            indent: 30,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('办公'),
            centerTitle: true,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      EnterExitRoute(
                          enterPage: SettingPage(), exitPage: this.widget));
                },
                child: SvgPicture.asset('assets/svg/tim_setting.svg',
                    width: 40.0, color: Colors.white),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(48)),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipTrapezoid(
                height: 200,
                child: Image.asset('assets/tim_bg.png'),
              ),
              Container(
                padding: EdgeInsets.only(top: 90),
                height: 200,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              Provider.of<UserState>(context).name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              Provider.of<UserState>(context).username,
                              style:
                                  TextStyle(color: Colors.white.withAlpha(125)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14),
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(.5), width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(.3))
                            ]),
                        child: InkWell(
                          onTap: () {
                            // 跳转页面
                            //Navigator.pushNamed(context, 'user_info_page');
                            Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (_, anim1, anim2) {
                              return UserInfoPage();
                            }));
                          },
                          child: ClipOval(
                            child: Image.asset(
                                Provider.of<UserState>(context).picture),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                getToolListItem(image: 'assets/riCheng.png', title: '日程'),
                getToolListItem(image: 'assets/email.png', title: '邮箱'),
                getToolListItem(image: 'assets/phone.png', title: '电话'),
                getToolListItem(image: 'assets/collection.png', title: '收藏'),
                getToolListItem(image: 'assets/qianBao.png', title: '钱包'),
                getToolListItem(image: 'assets/kongJian.png', title: '好友动态'),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
