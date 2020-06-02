import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const SettingScaffold({Key key, this.body, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f5f9),
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          title: title != null
              ? Text(
                  title,
                  style: TextStyle(color: Colors.black),
                )
              : Container(),
          leading: UnconstrainedBox(
            child: InkWell(
              onTap: () {
                Navigator.maybePop(context);
              },
              child: SvgPicture.asset(
                'assets/svg/tim_arrow_left.svg',
                width: 20,
                color: Color(0xff333333),
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(48),
      ),
      body: Column(children: <Widget>[
        Divider(
          thickness: .4,
          height: .4,
        ),
        Expanded(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: body ?? Container()))
      ]),
    );
  }
}
