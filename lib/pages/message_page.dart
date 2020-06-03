import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/client.dart';

import 'package:flutter_tim/pages/chat_page.dart';
import 'package:flutter_tim/pages/contacts_page.dart';
import 'package:flutter_tim/pages/friend_info_page.dart';
import 'package:flutter_tim/pages/home_page.dart';
import 'package:flutter_tim/pages/login_page.dart';
import 'package:flutter_tim/pages/message_page/auto_app_bar.dart';
import 'package:flutter_tim/pages/message_page/func_menu.dart';
import 'package:flutter_tim/pages/message_page/message_item.dart';
import 'package:flutter_tim/state/conversation_state.dart';
import 'package:flutter_tim/state/message_state.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:flutter_tim/utils/tim_refresh_header.dart';
import 'package:flutter_tim/widgets/enter_exit_route.dart';
import 'package:flutter_tim/widgets/fake_search_bar.dart';

import 'package:flutter_tim/api/api.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as cv;

class MessagePage extends StatefulWidget {

  final BuildContext homeContext;

  const MessagePage({Key key,@required this.homeContext}) : super(key: key);
  
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
    _scrollController = new ScrollController()..addListener(_appBarListener);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(onMounted);
  }

  onMounted(_) {
    // 请求会话数据
    // Dio().post(Api.getConversations, queryParameters: {
    //   'username': Provider.of<UserState>(this.context, listen: false).username
    // }).then((value) {
    //   List a = cv.jsonDecode(value.data)[0];
    //   Provider.of<ConversationState>(this.context, listen: false)
    //       .init(a.map((item) {
    //     // 这个Init执行完之后，消息列表的数据框架会显示出来
    //     return ConversationEntity(
    //         objectId: item['id'].toString(),
    //         objectName: item['remark'] ?? item['name'],
    //         objectPicture: item['picture'] ?? 'assets/touXiang.jpg',
    //         messages: []);
    //   }).toList());
    //   setState(() {});
    // }).whenComplete(() {
    //   Provider.of<ConversationState>(context, listen: false).data.forEach((c) {
    //     Dio().post(Api.getMessages, queryParameters: {
    //       'username':
    //           Provider.of<UserState>(this.context, listen: false).username,
    //       'friend': c.objectId,
    //       'startIndex': 0
    //     }).then((res) {
    //       List ms = cv.jsonDecode(res.data)[0];
    //       c.messages = (ms.map((m) {
    //         return MessageEntity(
    //             time: DateTime.parse(m['time']),
    //             content: m['content'],
    //             isMeSend: m['is_me_send'] == 1);
    //       }).toList());
    //       setState(() {});
    //     });
    //   });
    // });
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
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AutoAppBar(
          controler: _appBarControler,
          title: '消息',
          leftIcon: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FriendInfoPage();
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

              showDialog(
                  context: context,
                  builder: (_) {
                    return FuncMenu(
                      items: [
                        FuncItem(
                            icon: 'assets/svg/tim_create_chat.svg',
                            text: "创建群聊"),
                        FuncItem(
                            icon: 'assets/svg/tim_add_friend.svg',
                            text: "添加朋友"),
                        FuncItem(icon: 'assets/svg/tim_scan.svg', text: '扫一扫'),
                        FuncItem(
                            icon: 'assets/svg/tim_folder.svg', text: '面对面快传')
                      ],
                    );
                  });
            },
            child: SvgPicture.asset(
              'assets/svg/tim_add.svg',
              color: Colors.white,
              width: 40,
            ),
          )),
      drawerDragStartBehavior: DragStartBehavior.down,
      drawerEdgeDragWidth: 300.0,
      body: EasyRefresh(
        header: TimRefreshHeader(),
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 2000));
        },
        child: ListView(
          controller: _scrollController,
          //physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: <Widget>[
            FakeSearchBar(),
            ...Provider.of<ConversationState>(context).data.map((conv) {
              return MessageItem(
                data: conv,
                onTap: () {
                  Navigator.push(
                      context,
                      EnterExitRoute(
                          enterPage: ChatPage(conv: conv),
                          exitPage: widget.homeContext.widget));
                },
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
