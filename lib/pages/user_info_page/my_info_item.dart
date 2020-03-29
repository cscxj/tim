import 'package:flutter/material.dart';

class MyInfoItem extends StatelessWidget {
  final bool hasUnderLine;
  final String title;
  final String content;
  final Function onTap;
  final Widget extendLine;

  MyInfoItem({
    Key key,
    @required this.title,
    @required this.content,
    this.hasUnderLine: true,
    this.onTap,
    this.extendLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          color: Colors.white,
          onPressed: onTap ?? () {},
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff969696))),
                          Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                content,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: extendLine == null ? 16.0 : 14.0,
                                    fontWeight: FontWeight.normal),
                              )),
                          extendLine == null
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.only(top: 5),
                                  constraints: BoxConstraints(maxHeight: 16.0),
                                  child: extendLine,
                                )
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
        hasUnderLine
            ? Divider(
                height: 0,
                indent: 14.0,
              )
            : Container()
      ],
    );
  }
}
