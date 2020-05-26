import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tim/api/api.dart';
import 'package:flutter_tim/pages/contacts_page/group_item.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tim/widgets/fake_search_bar.dart';
import 'dart:convert' as cv;

class ContactGroup {
  String id;
  String name;
  int onlineCount;
  List<Contact> friends;

  ContactGroup({this.id, this.name, this.onlineCount, this.friends});
}

class Contact {
  String picture;
  String name;
  bool online;
  Contact({this.picture: '', this.name: '', this.online: false});
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Map<String, String>> subareaData = [
    {'icon': 'assets/svg/tim_friend.svg', 'text': '新朋友'},
    {'icon': 'assets/svg/tim_group.svg', 'text': '群聊'},
    {'icon': 'assets/svg/tim_business_card.svg', 'text': '名片夹'}
  ];
  List<ContactGroup> groups = [];

  fillData() {}

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   String username =
    //       Provider.of<UserState>(this.context, listen: false).username;
    //   Dio().post(Api.getGroups, queryParameters: {'username': username}).then(
    //       (v) {
    //     List data = cv.jsonDecode(v.data.toString());

    //     groups.addAll(data
    //         .map((i) => ContactGroup(
    //             name: i['name'],
    //             id: i['id'].toString(),
    //             onlineCount: 0,
    //             friends: []))
    //         .toList());
    //     print(groups.length);
    //   });
    // });

    // 假数据
    groups = [
      ContactGroup(id: "1", name: "我的好友", onlineCount: 11, friends: [
        Contact(picture: "assets/touXiang.jpg", name: "阿明", online: true),
        Contact(picture: "assets/touXiang.jpg", name: "a强", online: true)
      ]),
      ContactGroup(id: "1", name: "老师", onlineCount: 11, friends: [
        Contact(picture: "assets/touXiang.jpg", name: "狗贼", online: true),
        Contact(picture: "assets/touXiang.jpg", name: "妈蛋", online: true)
      ])
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xfff6f7f9),
          centerTitle: true,
          leading: Center(
              child: Text(
            '添加',
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          )),
          title: Text(
            '联系人',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            SvgPicture.asset(
              'assets/svg/tim_arrow_right.svg',
              width: 20.0,
              color: Colors.black,
            )
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (_, constrainters) {
          return Container(
            height: constrainters.maxHeight,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: <Widget>[
                  FakeSearchBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: subareaData.map((item) {
                      return Expanded(
                          child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 0),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    item['icon'],
                                    width: 36,
                                    color: Color(0xff333333),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 8)),
                                  Text(item['text'])
                                ],
                              )));
                    }).toList(),
                  ),
                  Divider(
                    height: .0,
                    thickness: .0,
                  ),
                  ...groups.map((data) {
                    return GroupItem(data: data);
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
