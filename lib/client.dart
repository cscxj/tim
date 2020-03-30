import 'package:flutter_tim/api/api.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Client{
  static WebSocketChannel channel;

  static connect(String username){
    channel = IOWebSocketChannel.connect(Api.connectSocketServer + username);
  }

  static close(){
    channel?.sink?.close();
  }
}