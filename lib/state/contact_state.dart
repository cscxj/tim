// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import '../api/api.dart';
// import 'dart:convert' as cv;

// class ContactGroup {
//   String name;
//   int onlineCount;
//   List<Contact> friends;
  
//   ContactGroup({this.name, this.onlineCount, this.friends});
// }

// class Contact {
//   String picture;
//   String name;
//   bool online;
//   Contact({this.picture:'', this.name:'', this.online:false});
// }
// class ContactState with ChangeNotifier {
//     Dio _dio;
//   List<ContactGroup> data = [];

//   ContactState(){
//     _dio = Dio();
//   }
  
//   update(String username){
//     _dio.post(api.getGroups,queryParameters: {
//       'username':username
//     }).then((g){
//       print(g);
//       notifyListeners();
//     });
//   }

// }