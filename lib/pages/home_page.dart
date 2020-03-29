import 'package:flutter/material.dart';
import 'package:flutter_tim/global.dart';
import 'package:flutter_tim/pages/contacts_page.dart';
import 'package:flutter_tim/pages/test.dart';
import 'package:flutter_tim/pages/message_page.dart';
import './work_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

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

