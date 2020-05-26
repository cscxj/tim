import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tim/api/api.dart';
import 'package:flutter_tim/pages/contacts_page.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'dart:convert' as cv;

class GroupItem extends StatefulWidget {
  final ContactGroup data;

  GroupItem({Key key, @required this.data})
      : assert(data != null, '联系人列表组件需要传入数据'),
        super(key: key);
  @override
  _GroupItemState createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  bool _display = false;

  @override
  void initState() {
    // Dio().post(Api.getFriends,
    //     queryParameters: {'groupId': widget.data.id}).then((v) {
    //   List friends = cv.jsonDecode(v.data.toString());
    //   widget.data.friends = List<Contact>.generate(friends.length, (index) {
    //     return Contact(
    //         name: friends[index]['remark'] ??
    //             friends[index]['name'], // 有备注就显示备注，没有备注显示用户昵称
    //         picture: 'assets/touXiang.jpg',
    //         online: false);
    //   });
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: FlatButton(
          color: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _display = !_display;
            });
          },
          child: Container(
            height: 40.0,
            child: Row(
              children: <Widget>[
                Icon(
                  _display ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Color(0xff666666),
                  size: 24,
                ),
                Text(
                  widget.data.name,
                  style: TextStyle(fontSize: 16.0),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Text(
                    '${widget.data.onlineCount}/${widget.data.friends.length}',
                    style: TextStyle(fontSize: 12.0, color: Color(0xff666666)),
                  ),
                )
              ],
            ),
          )),
      content: _display
          ? ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: widget.data.friends.map((contact) {
                return FlatButton(
                    onPressed: () {},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(horizontal: .0),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: ClipOval(
                                child: Image.asset(
                                  contact.picture,
                                  width: 48.0,
                                  height: 48.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(child: Text(contact.name))
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        indent: 60.0,
                      )
                    ]));
              }).toList(),
            )
          : Container(),
    );
  }
}
