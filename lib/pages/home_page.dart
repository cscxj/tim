import 'package:flutter/material.dart';
import 'package:flutter_tim/client.dart';

import 'package:flutter_tim/pages/contacts_page.dart';
import 'package:flutter_tim/pages/test.dart';
import 'package:flutter_tim/pages/message_page.dart';
import 'package:flutter_tim/state/message_state.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:provider/provider.dart';
import './work_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Client.connect(Provider.of<UserState>(context,listen: false).username);
      print('连接到Socket服务器');
      Client.channel.stream.listen((event) {

        // 模拟接收消息，现在可以收到消息了，还要还发送消息的数据，改成json数据
        print(event);
        Provider.of<MessageState>(context,listen: false).pushMsg(CMessage(
          time: DateTime.now(),
          content: event,
        ), '1000001');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: homePageKey,
      body: IndexedStack(
        index: _currentPage,
        children: <Widget>[MessagePage(), ContactsPage(), WorkPage()],
      ),
      bottomNavigationBar: Wrap(
        children: <Widget>[
          Divider(
            height: 0,
            thickness: .5,
          ),
          PreferredSize(
              child: BottomNavigationBar(
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
                  ]),
              preferredSize: Size.fromHeight(48))
        ],
      ),
    );
  }
}

