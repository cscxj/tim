class Api{
  ///方法：post  参数：username,password
  static const String login = 'http://192.168.0.104:7000/login';
  /// 方法：post 参数：username
  static const String getGroups = 'http://192.168.0.104:7000/get_groups';
  /// 方法：post 参数：groupId
  static const String getFriends = 'http://192.168.0.104:7000/get_friends';
}