import 'package:flutter/foundation.dart';

class UserState with ChangeNotifier {
  String username;

  String name;
  String password;
  int grade;
  String phone;
  String email;
  int sex;
  String birthday;
  String address;
  String hometown;
  String school;
  String company;
  String picture;
  String token;

  UserState(
      {@required username,
      name: '新用户',
      grade: 1,
      phone: '未填写',
      email: '未填写',
      sex: 0,
      birthday: '未填写',
      address: '未填写',
      hometown: '未填写',
      school: '未填写',
      company: '未填写',
      picture: 'assets/touXiang.jpg',
      token,
      password}) {
    this.username = username ?? '12345678';
    this.name = name ?? '新用户';
    this.grade = grade ?? 1;
    this.phone = phone ?? '未填写';
    this.email = email ?? '未填写';
    this.sex = sex ?? 0;
    this.birthday = birthday ?? '未填写';
    this.address = address ?? '未填写';
    this.hometown = hometown ?? '未填写';
    this.school = school ?? '未填写';
    this.company = company ?? '未填写';
    this.picture = picture ?? 'assets/touXiang.jpg';
    this.token = token ?? "";
    this.password = password ?? "";
  }

  update(
      {username,
      name,
      grade,
      phone,
      email,
      sex,
      birthday,
      address,
      hometown,
      school,
      company,
      picture,
      token,
      password}) {
    this.username = username ?? '12345678';
    this.name = name ?? '新用户';
    this.grade = grade ?? 1;
    this.phone = phone ?? '未填写';
    this.email = email ?? '未填写';
    this.sex = sex ?? 0;
    this.birthday = birthday ?? '未填写';
    this.address = address ?? '未填写';
    this.hometown = hometown ?? '未填写';
    this.school = school ?? '未填写';
    this.company = company ?? '未填写';
    this.picture = picture ?? 'assets/touXiang.jpg';
    this.token = token ?? "";
    this.password = password ?? "";

    notifyListeners();
  }
}

///
///{id: 1000000, name: 李四, join_date: 2020-03-22T16:26:39.000Z, grade: 2,
///password: 12345678, phone: null, email: null, sex: 0, birthday: null,
///address: null, hometown: null, school: null, company: null, picture: null}
