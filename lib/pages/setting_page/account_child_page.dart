import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class AccountChildPage extends StatefulWidget {
  @override
  _AccountChildPageState createState() => _AccountChildPageState();
}

class _AccountChildPageState extends State<AccountChildPage> {
  @override
  Widget build(BuildContext context) {
    var items = Column(
      children: <Widget>[
        SettingItem(
          title: '设备锁',
          containerContext: context,
          content: Row(
            children: <Widget>[
              Icon(
                Icons.lock,
                size: 14,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                '  已开启',
                style: TextStyle(color: Colors.black38),
              )
            ],
          ),
        ),
        SettingItem(
          title: '允许手机电脑同时在线',
          containerContext: context,
          type: SettingItemType.toggle,
          value: true,
        ),
        SettingItem(
          title: '手机防盗',
          containerContext: context,
          explainText: '开启后，可以远程定位手机，清除账号信息',
          isLast: true,
        ),
        SettingItem(
          title: '当前在线设备',
          containerContext: context,
          isLast: true,
        ),
        SettingItem(
          title: '最近登录记录...',
          containerContext: context,
          important: true,
          isLast: true,
        ),
        SettingItem(
          title: '手势密码锁定',
          containerContext: context,
          content: Text(
            '未设置',
            style: TextStyle(color: Colors.black38),
          ),
          isLast: true,
        ),
        SettingItem(
          title: 'TIM账号密码',
          containerContext: context,
        ),
        SettingItem(
          title: '安全登录检查',
          containerContext: context,
          isLast: true,
          type: SettingItemType.toggle,
          explainText: '开启后，TIM将在登陆时定期检查手机应用程序，防止木马、病毒、盗号等安全隐患',
        ),
        SettingItem(
          title: '注销账号',
          type: SettingItemType.none,
          containerContext: context,
        )
      ],
    );

    return ScrollReturnPage(
      child: SettingScaffold(
        title: '账号安全',
        body: items,
      ),
    );
  }
}
