import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class BasicChildPage extends StatefulWidget {
  @override
  _BasicChildPageState createState() => _BasicChildPageState();
}

class _BasicChildPageState extends State<BasicChildPage> {
  @override
  Widget build(BuildContext context) {
    var items = Column(
      children: <Widget>[
        SettingItem(title: '消息记录', containerContext: context),
        SettingItem(
          title: '空间清理',
          containerContext: context,
          isLast: true,
        ),
        SettingItem(
          title: '字体大小',
          containerContext: context,
          isLast: true,
        ),
        SettingItem(
          title: '流量统计',
          containerContext: context,
        ),
        SettingItem(
          title: '2G/3G/4G下自动接收图片',
          containerContext: context,
          type: SettingItemType.toggle,
          value: true,
        ),
        SettingItem(
          title: 'WiFi下自动后台下载新版本',
          containerContext: context,
          type: SettingItemType.toggle,
          isLast: true,
        ),
        SettingItem(
          title: '摇动手机截屏',
          containerContext: context,
          type: SettingItemType.toggle,
          explainText: '摇动手机可以截屏(TIM以外的界面需要开启Root权限)。',
          isLast: true,
        ),
        SettingItem(
          title: '系统通知栏显示TIM图标',
          containerContext: context,
          type: SettingItemType.toggle,
        ),
        SettingItem(
          title: '回车键发送消息',
          containerContext: context,
          type: SettingItemType.toggle,
        ),
        SettingItem(
          title: '联系人列表按字母排序',
          containerContext: context,
          type: SettingItemType.toggle,
        ),
        SettingItem(
          title: '消息只能语义识别和应用匹配',
          containerContext: context,
          type: SettingItemType.toggle,
          value: true,
          isLast: true,
        ),
      ],
    );
    return ScrollReturnPage(
      child: SettingScaffold(
        title: '通用',
        body: items,
      ),
    );
  }
}
