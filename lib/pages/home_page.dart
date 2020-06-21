import 'package:flutter/material.dart';
import 'package:flutter_tim/client.dart';

import 'package:flutter_tim/pages/contacts_page.dart';
import 'package:flutter_tim/pages/message_page.dart';
import 'package:flutter_tim/state/conversation_state.dart';
import 'package:flutter_tim/state/message_state.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:provider/provider.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import './work_page.dart';
import 'dart:convert' as cv;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      RongIMClient.init('vnroth0kvls5o');

      RongIMClient.connect(Provider.of<UserState>(context, listen: false).token,
          (code, userId) => {print("用户$userId登录成功")});

      RongIMClient.onMessageReceivedWrapper =
          (Message msg, int left, bool hasPackage, bool offline) {
        print("离线消息:" + msg.content.encode() + " left:" + left.toString());
      };
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //Client.channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBar2 = BottomNavigationBar(
        elevation: 0,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        currentIndex: _currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Container(),
              icon: Image.asset(
                'assets/message.png',
                width: 30,
              ),
              activeIcon: Image.asset(
                'assets/message_ed.png',
                width: 30,
              )),
          BottomNavigationBarItem(
              title: Container(),
              icon: Image.asset(
                'assets/document.png',
                width: 30,
              ),
              activeIcon: Image.asset(
                'assets/document_ed.png',
                width: 30,
              )),
          BottomNavigationBarItem(
              title: Container(),
              icon: Image.asset(
                'assets/tool.png',
                width: 30,
              ),
              activeIcon: Image.asset(
                'assets/tool_ed.png',
                width: 30,
              )),
        ]);
    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: <Widget>[
          MessagePage(
            homeContext: context,
          ),
          ContactsPage(),
          WorkPage()
        ],
      ),
      bottomNavigationBar: Wrap(
        children: <Widget>[
          Divider(
            height: 0,
            thickness: .5,
          ),
          PreferredSize(
              child: bottomNavigationBar2, preferredSize: Size.fromHeight(48))
        ],
      ),
    );
  }
}
