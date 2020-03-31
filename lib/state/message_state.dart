import 'package:flutter/foundation.dart';

// 每个会话去监听自己的消息，而不是收到消息后分配到对应的会话

// 消息实体类
class MessageEntity {
  DateTime time;
  String content;
  bool isMeSend;
  MessageEntity({this.time, this.content,this.isMeSend:false});
}

/// 消息管理类
class MessageState with ChangeNotifier {
  List<MessageEntity> data = [];//存放消息数据

  // 初始化消息列表
  init(List<MessageEntity> msgs){
    this.data = msgs;
    notifyListeners();
  }
  
  // 插入一条新消息
  push(MessageEntity msg){
    data.add(msg);
    notifyListeners();
  }
}

/// 接收消息
/// Client.channel.stream.listen((event) {
      //   // 模拟接收消息，现在可以收到消息了，还要还发送消息的数据，改成json数据
      //   print(event);
      //   Map<String, dynamic> ms = cv.jsonDecode(event);

      //   Provider.of<MessageState>(context, listen: false).pushMsg(
      //       CMessage(
      //         time: ms['time'] is int
      //             ? DateTime.fromMillisecondsSinceEpoch(ms['time'])
      //             : DateTime.parse(ms['time']),
      //         content: ms['content'],
      //       ),
      //       ms['master']);
      // });

    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Dio().post(Api.getConversations, queryParameters: {
    //     'username': Provider.of<UserState>(this.context, listen: false).username
    //   }).then((value) {
    //     List a = cv.jsonDecode(value.data)[0];
    //     _conversations = a.map((item) {
    //       return ConversationEntity(
    //           objectId: item['id'].toString(),
    //           objectName: item['remark'] ?? item['name'],
    //           objectPicture: item['picture'] ?? 'assets/touXiang.jpg',
    //           messages: [
    //             CMessage(
    //                 time: DateTime.parse(item['time']),
    //                 content: item['content'])
    //           ]);
    //     }).toList();

        

    //     Provider.of<MessageState>(this.context, listen: false)
    //         .init(_conversations);
    //     // 请求消息
    //     List<Future> requestMessageTasks = [];
    //     Provider.of<MessageState>(this.context, listen: false)
    //         .data
    //         .forEach((conv) {
    //       requestMessageTasks.add(Dio().post(Api.getMessages, queryParameters: {
    //         'username':
    //             Provider.of<UserState>(this.context, listen: false).username,
    //         'friend': conv.objectId,
    //         'startIndex': 0
    //       }).then((res) {
    //         List ms = cv.jsonDecode(res.data)[0];
    //         conv.messages = ms.reversed.map((m) {
    //           return CMessage(
    //               time: DateTime.parse(m['time']),
    //               content: m['content'],
    //               isMeSend: m['is_me_send'] == 1);
    //         }).toList();
    //       }));
    //     });
    //     // 消息初始化完之后,监听服务
    //     Future.wait(requestMessageTasks).then((_) {
    //       print('消息初始化完成了');
    //     });
    //   });
    // });