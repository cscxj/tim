import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/pages/setting_page/setting_item.dart';
import 'package:flutter_tim/pages/setting_page/setting_scaffold.dart';
import 'package:flutter_tim/widgets/scroll_return_page.dart';

class UserChildPage extends StatefulWidget {
  @override
  _UserChildPageState createState() => _UserChildPageState();
}

class _UserChildPageState extends State<UserChildPage> {
  @override
  Widget build(BuildContext context) {
    return ScrollReturnPage(
      child: SettingScaffold(
        title: '账号管理',
        action: '编辑',
        body: Column(
          children: <Widget>[
            _LocalUser(
              picture: 'assets/touXiang.jpg',
              name: '~~',
              account: '2191505874',
              action: true,
            ),
            _LocalUser(
              picture: 'assets/touXiang.jpg',
              name: '癸亥',
              account: '2760185289',
            ),
            _AddButton(),
            Padding(padding: EdgeInsets.only(top: 20)),
            SettingItem(
              title: '在线状态',
              containerContext: context,
              content: Text(
                '在线',
                style: TextStyle(color: Colors.black38),
              ),
              isLast: true,
            ),
            SettingItem(
              title: '手机号码',
              containerContext: context,
              content: Text(
                '未绑定',
                style: TextStyle(color: Colors.black38),
              ),
            ),
            SettingItem(
              title: '关联账号',
              containerContext: context,
              isLast: true,
              explainText: '关联账号后，即可代收该账号的好友信息。',
            ),
            SettingItem(
              title: '退出当前账号',
              type: SettingItemType.none,
              containerContext: context,
              isLast: true,
            )
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Function onPressed;

  const _AddButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: onPressed ?? () {},
        child: SizedBox(
            height: 40,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 5),
                  child: SvgPicture.asset(
                    'assets/svg/tim_add2.svg',
                    width: 30,
                  ),
                ),
                Text('添加账号')
              ],
            )));
  }
}

class _LocalUser extends StatelessWidget {
  final bool action;
  final String name;
  final String account;
  final String picture;
  final Function onPressed;

  const _LocalUser(
      {Key key,
      this.action: false,
      @required this.name,
      @required this.account,
      @required this.picture,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: onPressed ?? () {},
          child: SizedBox(
            height: 40,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      picture,
                      width: 40,
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                    ),
                    Text(
                      account,
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    )
                  ],
                )),
                action
                    ? Icon(
                        Icons.check,
                        size: 20,
                      )
                    : Container()
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          indent: 16,
        )
      ],
    );
  }
}
