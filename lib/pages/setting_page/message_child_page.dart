import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class MessageChildPage extends StatefulWidget {
  @override
  _MessageChildPageState createState() => _MessageChildPageState();
}

class _MessageChildPageState extends State<MessageChildPage> {
  @override
  Widget build(BuildContext context) {
    var items = Column(
      children: <Widget>[
        SettingItem(
          title: '开启TIM消息通知',
          containerContext: context,
          explainText: '设置此项保证TIM的消息能及时通知到您',
          isLast: true,
        ),
        SettingItem(
          title: '声音',
          containerContext: context,
        ),
        SettingItem(
          title: '通知显示消息内容',
          containerContext: context,
          type: SettingItemType.toggle,
        ),
        SettingItem(
          title: '通知时指示灯闪烁',
          containerContext: context,
          type: SettingItemType.toggle,
        ),
        SettingItem(
          title: '桌面图标显示未读消息数',
          containerContext: context,
          type: SettingItemType.toggle,
        ),
        SettingItem(
          title: '与我相关的通知',
          containerContext: context,
          type: SettingItemType.toggle,
          value: true,
        ),
        SettingItem(
          title: '退出后仍然接收消息通知',
          containerContext: context,
          type: SettingItemType.toggle,
          isLast: true,
        ),
        SettingItem(
          title: '夜间放扰模式',
          containerContext: context,
          type: SettingItemType.toggle,
          isLast: true,
          explainText: '开启后，将自动屏蔽23:00-8:00间的任何提醒.',
        ),
        SettingItem(
          title: '群消息设置',
          containerContext: context,
          isLast: true,
        )
      ],
    );
    return ScrollReturnPage(
      child: SettingScaffold(
        title: '新消息通知',
        body: items,
      ),
    );
  }
}
