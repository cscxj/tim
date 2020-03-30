import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/client.dart';

import 'package:flutter_tim/pages/chat_page.dart';
import 'package:flutter_tim/pages/contacts_page.dart';
import 'package:flutter_tim/pages/home_page.dart';
import 'package:flutter_tim/pages/login_page.dart';
import 'package:flutter_tim/pages/message_page/auto_app_bar.dart';
import 'package:flutter_tim/pages/message_page/message_item.dart';
import 'package:flutter_tim/state/message_state.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:flutter_tim/widgets/enter_exit_route.dart';
import 'package:flutter_tim/widgets/fake_search_bar.dart';
import 'package:flutter_tim/api/api.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert' as cv;

import 'package:web_socket_channel/web_socket_channel.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

enum AppBarState {
  show,
  hide,
}

class _MessagePageState extends State<MessagePage> {
  AutoAppBarControler _appBarControler;
  ScrollController _scrollController;

  AppBarState _appBarState = AppBarState.show;
  @override
  void initState() {
    _appBarControler = new AutoAppBarControler();
    super.initState();

    _scrollController = new ScrollController()..addListener(_appBarListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Dio().post(Api.getConversations, queryParameters: {
        'username': Provider.of<UserState>(this.context, listen: false).username
      }).then((value) {
        List a = cv.jsonDecode(value.data)[0];
        List<ConversationEntity> conversations = a.map((item) {
          return ConversationEntity(
              objectId: item['id'].toString(),
              objectName: item['remark'] ?? item['name'],
              objectPicture: item['picture'] ?? 'assets/touXiang.jpg',
              messages: [
                CMessage(
                    time: DateTime.parse(item['time']),
                    content: item['content'])
              ]);
        }).toList();

        Provider.of<MessageState>(this.context, listen: false)
            .init(conversations);
        // 请求消息
        List<Future> requestMessageTasks = [];
        Provider.of<MessageState>(this.context, listen: false)
            .data
            .forEach((conv) {
          requestMessageTasks.add(Dio().post(Api.getMessages, queryParameters: {
            'username':
                Provider.of<UserState>(this.context, listen: false).username,
            'friend': conv.objectId,
            'startIndex': 0
          }).then((res) {
            List ms = cv.jsonDecode(res.data)[0];
            conv.messages = ms.reversed.map((m) {
              return CMessage(
                  time: DateTime.parse(m['time']),
                  content: m['content'],
                  isMeSend: m['is_me_send'] == 1);
            }).toList();
          }));
        });
        // 消息初始化完之后,监听服务
        Future.wait(requestMessageTasks).then((_) {
          print('消息初始化完成了');
        });
      });
    });
  }

  

  double preOffset = 0.0;
  double offset = 0.0;

  void _appBarListener() {
    if (_scrollController.offset < _scrollController.position.maxScrollExtent) {
      preOffset = offset;
      offset = _scrollController.offset;
      if (offset - preOffset > 3.0) {
        _appBarControler.hide();
        _appBarState = AppBarState.hide;
      } else if (offset - preOffset < -3.0) {
        _appBarControler.show();
        _appBarState = AppBarState.show;
      }
    }
    // 因为滑动速度慢的时候appbar不会变化，防止滑到顶端还隐藏appBar
    if (_scrollController.offset <
            MediaQuery.of(context).padding.top + 48 + 80 &&
        _appBarState == AppBarState.hide) {
      _appBarControler.show(); // 显示appBar
      _appBarState = AppBarState.show;
    }
  }

  @override
  Widget build(BuildContext context) {
    MessageState conversations = Provider.of<MessageState>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AutoAppBar(
          controler: _appBarControler,
          title: '消息',
          leftIcon: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ContactsPage();
              }));
            },
            child: SvgPicture.asset(
              'assets/svg/tim_contact.svg',
              color: Colors.white,
              width: 40,
            ),
          ),
          rightIcon: InkWell(
            onTap: () {
              // Navigator.push(context, CupertinoPageRoute(builder: (_) {
              //   return LoginPage();
              // }));
            },
            child: SvgPicture.asset(
              'assets/svg/tim_add.svg',
              color: Colors.white,
              width: 40,
            ),
          )),
      drawerDragStartBehavior: DragStartBehavior.down,
      drawerEdgeDragWidth: 300.0,
      body: ListView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          FakeSearchBar(),
          ...conversations.data.map((conv) {
            return MessageItem(
              data: conv,
              onTap: () {
                Navigator.push(
                    context,
                    EnterExitRoute(
                        enterPage: ChatPage(conv: conv),
                        exitPage: context.widget));
              },
            );
          }).toList()
        ],
      ),
    );
  }
}
