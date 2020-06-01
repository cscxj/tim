import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/single_child_widget.dart';

class FuncItem {
  final String icon;
  final String text;
  final Function onTap;
  FuncItem({this.onTap, this.icon, this.text: ""});
}

class FuncMenu extends StatefulWidget {
  final List<FuncItem> items;

  const FuncMenu({Key key, @required this.items}) : super(key: key);

  @override
  _FuncMenuState createState() => _FuncMenuState();
}

class _FuncMenuState extends State<FuncMenu> with TickerProviderStateMixin {
  AnimationController _enterAnim;

  @override
  void initState() {
    super.initState();
    _enterAnim =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _enterAnim.addListener(() {
      setState(() {});
    });
    _enterAnim.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: 48,
          left: screenSize.width - 180,
          bottom: screenSize.height - 60 * widget.items.length - 48),
      child: Transform.scale(
        origin: Offset(90, -105),
        scale: _enterAnim.value,
        child: Material(
          child: Container(
            color: Colors.white,
            child: Column(
              children: widget.items
                  .map((menuItem) => Expanded(
                      child: FlatButton(
                          onPressed: menuItem.onTap ?? () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: SvgPicture.asset(
                                  menuItem.icon,
                                  color: Colors.black,
                                  width: 36,
                                ),
                              ),
                              Text(
                                menuItem.text,
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ))))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
