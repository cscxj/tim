import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 48.0 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Color(0xfff6f7f9),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 5.0),
                      child: SvgPicture.asset(
                        'assets/svg/tim_arrow_left.svg',
                        color: Colors.black.withOpacity(.9),
                        width: 20,
                      ),
                    ),
                    Text(
                      '消息',
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.black.withOpacity(.9)),
                    )
                  ],
                ),
              )),
              ConstrainedBox(
                  child: Text(
                    'flutter开发者社区',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.9), fontSize: 20.0),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 140.0,
                  )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/svg/tim_search.svg',
                    width: 40.0,
                    color: Colors.black.withOpacity(.7),
                  ),
                  SvgPicture.asset('assets/svg/tim_group_small.svg',
                      width: 40.0, color: Colors.black.withOpacity(.7)),
                ],
              ))
            ],
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
