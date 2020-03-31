// class Api{
//   // 需要路由参数：username
//   static const String connectSocketServer = 'ws://192.168.0.100:7001/'; 

//   ///方法：post  参数：username,password
//   static const String login = 'http://192.168.0.100:7000/login';
//   /// 方法：post 参数：username
//   static const String getGroups = 'http://192.168.0.100:7000/get_groups';
//   /// 方法：post 参数：groupId
//   static const String getFriends = 'http://192.168.0.100:7000/get_friends';
//   /// 方法：post 参数：username
//   static const String getConversations = 'http://192.168.0.100:7000/get_conversations';
//   /// 方法：post 参数：username,friend,startIndex
//   static const String getMessages = 'http://192.168.0.100:7000/get_messages';
// }

class Api{
  // 需要路由参数：username
  static const String connectSocketServer = 'ws://47.106.226.127:7001/'; 

  ///方法：post  参数：username,password
  static const String login = 'http://47.106.226.127:7000/login';
  /// 方法：post 参数：username
  static const String getGroups = 'http://47.106.226.127:7000/get_groups';
  /// 方法：post 参数：groupId
  static const String getFriends = 'http://47.106.226.127:7000/get_friends';
  /// 方法：post 参数：username
  static const String getConversations = 'http://47.106.226.127:7000/get_conversations';
  /// 方法：post 参数：username,friend,startIndex
  static const String getMessages = 'http://47.106.226.127:7000/get_messages';
}