import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ScrollReturnPage(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '设置',
            style: TextStyle(color: Colors.black),
          ),
          leading: UnconstrainedBox(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/svg/tim_arrow_left.svg',
                width: 20,
                color: Color(0xff333333),
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Divider(
              thickness: .4,
              height: .4,
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: <Widget>[
                  SettingItem(
                    title: '账号管理',
                    content: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/touXiang.jpg',
                        width: 40,
                      ),
                    ),
                  ),
                  SettingItem(
                    title: '账号安全',
                    isLast: true,
                    content: Row(
                      children: <Widget>[
                        Icon(
                          Icons.lock,
                          size: 14,
                          color: Colors.black38,
                        ),
                        Text(
                          '  未开启',
                          style: TextStyle(color: Colors.black38),
                        )
                      ],
                    ),
                  ),
                  SettingItem(title: '消息通知'),
                  SettingItem(title: '隐私'),
                  SettingItem(
                    title: '通用',
                    isLast: true,
                  ),
                  SettingItem(
                    title: '功能',
                    isLast: true,
                  ),
                  SettingItem(
                    title: '关于TIM与帮助',
                    isLast: true,
                  ),
                  SettingItem(
                    title: '退出TIM',
                    isLast: true,
                    type: SettingItemType.none,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
