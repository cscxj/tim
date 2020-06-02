import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class AboutChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var items = <Widget>[
      Padding(padding: EdgeInsets.only(top: 40)),
      SvgPicture.asset(
        'assets/svg/logo.svg',
        width: 70,
      ),
      Text('TIM',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          )),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'V 1.0.0.0',
          style: TextStyle(fontSize: 18, color: Colors.black38),
        ),
      ),
      SettingItem(
          title: '版本更新',
          containerContext: context,
          type: SettingItemType.none,
          content: Text(
            '已是最新版本',
            style: TextStyle(color: Colors.black38),
          )),
      SettingItem(title: '隐私政策', containerContext: context),
      SettingItem(
        title: '权限说明',
        containerContext: context,
      ),
      SettingItem(title: '帮助', containerContext: context),
      SettingItem(
        title: '反馈',
        containerContext: context,
        isLast: true,
      ),
    ];
    return ScrollReturnPage(
      child: SettingScaffold(
        title: '关于TIM与帮助',
        body: Column(
          children: items,
        ),
      ),
    );
  }
}
