import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.black.withOpacity(.5),
      elevation: 0,
      insetPadding:
          EdgeInsets.only(bottom: screenHeight - 120, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(),
            Text(
              "  正在登录...",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
