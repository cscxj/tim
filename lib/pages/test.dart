import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverflowBox(
        child: Row(
          children: <Widget>[
            Container(
              height: 70.0,
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
            ),
          ], 
        ), 
      )
    );
  }
}


