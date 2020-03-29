import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(2.0)) 
      ),
      constraints: BoxConstraints(
        maxHeight: 30 
      ),
      child: TextField(
        cursorColor: Colors.black,
        cursorWidth: 1.0,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          fillColor: Colors.red,
          hintText: '搜索'
        ),
      ),
    );
  }
}