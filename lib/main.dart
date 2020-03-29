import 'package:flutter/material.dart';
import 'package:flutter_tim/pages/home_page.dart';
import 'package:flutter_tim/pages/login_page.dart';
import 'package:flutter_tim/pages/user_info_page.dart';
import 'package:flutter_tim/state/contact_state.dart';
import 'package:flutter_tim/state/message_state.dart';
import 'package:flutter_tim/state/user_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState(username: null)),
        ChangeNotifierProvider(create: (_)=>MessageState())
      ],
      child: MaterialApp(
        routes: {
          '/': (_) => LoginPage(),
          'user_info_page': (_) => UserInfoPage(),
        },
      ),
    ));
