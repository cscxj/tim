import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/setting_page/about_child_page.dart';
import 'package:flutter_tim/pages/setting_page/account_child_page.dart';
import 'package:flutter_tim/pages/setting_page/app_child_page.dart';
import 'package:flutter_tim/pages/setting_page/basic_child_page.dart';
import 'package:flutter_tim/pages/setting_page/message_child_page.dart';
import 'package:flutter_tim/pages/setting_page/privacy_child_page.dart';
import 'package:flutter_tim/pages/setting_page/user_child_page.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var items = Column(
      children: <Widget>[
        SettingItem(
          containerContext: context,
          title: '账号管理',
          nextPage: UserChildPage(),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              'assets/touXiang.jpg',
              width: 40,
            ),
          ),
        ),
        SettingItem(
          containerContext: context,
          title: '账号安全',
          nextPage: AccountChildPage(),
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
        SettingItem(
          containerContext: context,
          title: '消息通知',
          nextPage: MessageChildPage(),
        ),
        SettingItem(
          containerContext: context,
          title: '隐私',
          nextPage: PrivacyChildPage(),
        ),
        SettingItem(
          containerContext: context,
          title: '通用',
          isLast: true,
          nextPage: BasicChildPage(),
        ),
        SettingItem(
          containerContext: context,
          title: '功能',
          isLast: true,
          nextPage: AppChildPage(),
        ),
        SettingItem(
          containerContext: context,
          title: '关于TIM与帮助',
          isLast: true,
          nextPage: AboutChildPage(),
        ),
        SettingItem(
          containerContext: context,
          title: '退出TIM',
          isLast: true,
          type: SettingItemType.none,
        )
      ],
    );
    return ScrollReturnPage(
      child: SettingScaffold(
        title: '设置',
        body: items,
      ),
    );
  }
}
