class Api{
  static const String serverIp = "192.168.0.110";
  static const String serverPort= "3333";
  // 需要路由参数：username
  static const String connectSocketServer = 'ws://$serverIp:$serverPort/'; 

  ///方法：post  参数：username,password
  static const String login = 'http://$serverIp:$serverPort/login';
  ///方法：post  参数：email_address
  static const String register = 'http://$serverIp:$serverPort/get_code';
  
  /// 方法：post 参数：username
  static const String getGroups = 'http://$serverIp:$serverPort/get_groups';
  /// 方法：post 参数：groupId
  static const String getFriends = 'http://$serverIp:$serverPort/get_friends';
  /// 方法：post 参数：username
  static const String getConversations = 'http://$serverIp:$serverPort/get_conversations';
  /// 方法：post 参数：username,friend,startIndex
  static const String getMessages = 'http://$serverIp:$serverPort/get_messages';
}