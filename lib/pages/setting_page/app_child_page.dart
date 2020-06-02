import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class AppChildPage extends StatefulWidget {
  @override
  _AppChildPageState createState() => _AppChildPageState();
}

class _AppChildPageState extends State<AppChildPage> {
  List appData = [
    {
      'icon': 'assets/riCheng.png',
      'title': '日程',
      'nav': Container(),
      'enable': true
    },
    {
      'icon': 'assets/email.png',
      'title': '邮箱',
      'nav': Container(),
      'enable': true
    },
    {
      'icon': 'assets/collection.png',
      'title': '收藏',
      'nav': Container(),
      'enable': true
    },
    {
      'icon': 'assets/qianBao.png',
      'title': '钱包',
      'nav': Container(),
      'enable': false
    },
    {
      'icon': 'assets/kongJian.png',
      'title': '好友动态',
      'nav': Container(),
      'enable': false
    },
  ];

  Widget getLabel(String text) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(
              text,
              style: TextStyle(color: Colors.black38),
            ),
          ),
          Divider(
            height: 0,
            indent: 16,
          )
        ],
      ),
    );
  }

  Iterable genItems(Iterable data) {
    int index = 0;
    return data.map((e) {
      index++;
      return SettingItem(
        title: e['title'],
        containerContext: context,
        icon: e['icon'],
        isLast: index == data.length,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Iterable enables = appData.where((element) => element['enable']);
    Iterable unEnables = appData.where((element) => !element['enable']);

    Widget enablesView = enables.isEmpty
        ? Container()
        : Column(
            children: <Widget>[getLabel('已启用的功能'), ...genItems(enables)],
          );

    Widget unEnablesView = unEnables.isEmpty
        ? Container()
        : Column(
            children: <Widget>[getLabel('已关闭的功能'), ...genItems(unEnables)],
          );

    return ScrollReturnPage(
      child: SettingScaffold(
        title: '功能',
        body: Column(
          children: <Widget>[enablesView, unEnablesView],
        ),
      ),
    );
  }
}
