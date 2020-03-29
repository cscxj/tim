import 'package:flutter/foundation.dart';
/// 会话
class ConversationEntity {
  String objectName;
  String objectPicture;
  List<CMessage> messages;

  ConversationEntity({this.messages, this.objectName, this.objectPicture});
}

class CMessage {
  String time;
  String content;
  bool isMeSend;//是不是我发出的
  CMessage({this.time, this.content,this.isMeSend:false});
}

class MessageState with ChangeNotifier {
  List<ConversationEntity> data = [
    ConversationEntity(
        objectName: '张三',
        objectPicture: 'assets/touXiang.jpg',
        messages: [
          CMessage(time: '8:55', content: '在吗？'),
          CMessage(time: '8:55', content: '晚上有空吗？'),
          CMessage(time: '8:55', content: '激发了世界的分厘卡圣诞节法律上地方',isMeSend: true)
        ]),
    ConversationEntity(
        objectName: '王五',
        objectPicture: 'assets/touXiang.jpg',
        messages: [
          CMessage(time: '8:55', content: '所发射东风 '),
          CMessage(time: '8:55', content: '啊的结果'),
          CMessage(time: '8:55', content: '人家给vi岁的女',isMeSend: true)
        ])
  ];
}
