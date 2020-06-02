import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class PrivacyChildPage extends StatefulWidget {
  @override
  _PrivacyChildPageState createState() => _PrivacyChildPageState();
}

class _PrivacyChildPageState extends State<PrivacyChildPage> {
  @override
  Widget build(BuildContext context) {
    var items = Column(
      children: <Widget>[
        SettingItem(title: '手机通讯录', containerContext: context),
        SettingItem(
          title: '加好友设置',
          containerContext: context,
          isLast: true,
        ),
        SettingItem(
          title: '推荐可能认识的人',
          containerContext: context,
          isLast: true,
          type: SettingItemType.toggle,
          explainText: '开启\"推荐可能认识的人\"，TIM将为你推荐可能认识的人，或向可能认识的人推荐你',
        ),
        SettingItem(
          title: '特别关心',
          containerContext: context,
          content: Text(
            '暂无',
            style: TextStyle(color: Colors.black38),
          ),
        ),
        SettingItem(
          title: '不常用联系人',
          containerContext: context,
          isLast: true,
          content: Text(
            '暂无',
            style: TextStyle(color: Colors.black38),
          ),
        ),
        SettingItem(
          title: '可以通过系统通讯录发起TIM聊天',
          containerContext: context,
          type: SettingItemType.toggle,
          isLast: true,
        ),
        SettingItem(
          title: '向好友展示网络状态',
          containerContext: context,
          type: SettingItemType.toggle,
          isLast: true,
        ),
      ],
    );
    return ScrollReturnPage(
      child: SettingScaffold(
        title: '隐私',
        body: items,
      ),
    );
  }
}
