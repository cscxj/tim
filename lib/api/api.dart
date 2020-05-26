class Api{
  static const String serverIp = "47.106.226.127";
  // 需要路由参数：username
  static const String connectSocketServer = 'ws://$serverIp:7001/'; 

  ///方法：post  参数：username,password
  static const String login = 'http://$serverIp:7000/login';
  ///方法：post  参数：email_address
  static const String register = 'http://$serverIp:7000/get_code';
  
  /// 方法：post 参数：username
  static const String getGroups = 'http://$serverIp:7000/get_groups';
  /// 方法：post 参数：groupId
  static const String getFriends = 'http://$serverIp:7000/get_friends';
  /// 方法：post 参数：username
  static const String getConversations = 'http://$serverIp:7000/get_conversations';
  /// 方法：post 参数：username,friend,startIndex
  static const String getMessages = 'http://$serverIp:7000/get_messages';
}