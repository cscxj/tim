import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tim/widgets/enter_exit_route.dart';

class SettingItem extends StatefulWidget {
  /// 在前面显示图标，传入位图的资源路径
  final String icon;

  /// 设置项的标题
  final String title;

  /// 设置项的内容
  final Widget content;
  // 设置项的类型，可能是打开到下一页，可能是一个切换按钮，也可能什么都没有
  final SettingItemType type;

  /// 配合type使用，如果type为SettingItemType.toggle，则需要这么值，默认为false
  final bool value;

  /// 配合type使用，如果type为nav，则在这里传入要跳转的下一页
  final Widget nextPage;

  /// 配合type使用，乳沟type为none，这用此参数指定点击事件
  final Function onPress;

  /// 是否为结束项，结束项没有下划线，有外边距
  final bool isLast;

  /// 实现路由动画所需
  final BuildContext containerContext;

  /// 显示在item下方的说明文字
  final String explainText;

  /// 重要的设置项标题显示为主题色
  final bool important;

  const SettingItem(
      {Key key,
      @required this.title,
      this.content,
      this.type: SettingItemType.nav,
      this.value: false,
      this.nextPage,
      this.onPress,
      this.isLast: false,
      @required this.containerContext,
      this.icon,
      this.explainText,
      this.important: false})
      : super(key: key);
  @override
  _SettingItemState createState() => _SettingItemState(value);
}

class _SettingItemState extends State<SettingItem> {
  bool _isEnable;

  _SettingItemState(bool value) {
    this._isEnable = value;
  }

  @override
  Widget build(BuildContext context) {
    Widget right = Container();
    switch (widget.type) {
      case SettingItemType.nav:
        right = SvgPicture.asset(
          'assets/svg/tim_arrow_right.svg',
          width: 16,
          color: Colors.black38,
        );
        break;
      case SettingItemType.toggle:
        right = Switch(
            value: _isEnable,
            onChanged: (value) {
              setState(() {
                _isEnable = !_isEnable;
              });
            });
        break;
      default:
        right = Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 14),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            if (widget.nextPage != null && widget.type == SettingItemType.nav) {
              Navigator.push(
                  context,
                  EnterExitRoute(
                      enterPage: widget.nextPage,
                      exitPage: widget.containerContext.widget));
            } else if (widget.type == SettingItemType.toggle) {
              setState(() {
                _isEnable = !_isEnable;
              });
            } else if (widget.onPress != null &&
                widget.type == SettingItemType.none) {
              widget.onPress();
            }
          },
          child: SizedBox(
            height: 54,
            child: Row(
              children: <Widget>[
                widget.icon != null
                    ? Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Image.asset(
                          widget.icon,
                          width: 24,
                        ),
                      )
                    : Container(),
                Expanded(
                    child: Text(
                  widget.title ?? "",
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.important
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                )),
                widget.content ?? Container(),
                right
              ],
            ),
          ),
        ),
        widget.explainText != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(
                  widget.explainText,
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
              )
            : Container(),
        widget.isLast
            ? Padding(padding: EdgeInsets.only(top: 20))
            : Divider(
                height: 0,
                indent: 14,
              )
      ],
    );
  }
}

enum SettingItemType { toggle, nav, none }
