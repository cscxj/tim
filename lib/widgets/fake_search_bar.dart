import 'package:flutter/material.dart';
/// 假的搜索栏
class FakeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      height: 28.0,
      decoration: BoxDecoration(
        color: Color(0xfff7f8fa),
        borderRadius: BorderRadius.all(Radius.circular(2.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/search.png',width: 14.0,),
          Text(' 搜索', style: TextStyle(
            color: Color(0xff999999)
          )),
        ], 
      ),
    );
  }
}