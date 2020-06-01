import 'package:flutter/cupertino.dart';
import 'package:flutter_tim/state/message_state.dart';

/// 会话
class ConversationEntity with ChangeNotifier {
  String objectId;
  String objectName;
  String objectPicture;
  List<MessageEntity> messages;

  ConversationEntity(
      {this.objectId, this.objectName, this.objectPicture, this.messages});

  pushMsg(MessageEntity msg) {
    this.messages.insert(0, msg);
  }
}

/// 会话管理类
class ConversationState with ChangeNotifier {
  List<ConversationEntity> data = []; // 存放所有的会话

  ConversationState() {
    // 填充假数据
    this.data = [
      ConversationEntity(
          objectId: "1",
          objectName: "张三",
          objectPicture: "assets/touXiang.jpg",
          messages: [
            MessageEntity(
                time: DateTime.now(), content: "aaa", isMeSend: false),
          ]),
      ConversationEntity(
          objectId: "1",
          objectName: "李四",
          objectPicture: "assets/touXiang.jpg",
          messages: [
            MessageEntity(
                time: DateTime.now(), content: "bbb", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "df", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "dsg👌", isMeSend: true),
          ]),
      ConversationEntity(
          objectId: "1",
          objectName: "王五",
          objectPicture: "assets/touXiang.jpg",
          messages: [
            MessageEntity(
                time: DateTime.now(), content: "dsger", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "ffmmet", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "dfsgd", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "dsgr", isMeSend: true),
            MessageEntity(
                time: DateTime.now(), content: "adsrg", isMeSend: false),
          ]),
      ConversationEntity(
          objectId: "1",
          objectName: "赵六",
          objectPicture: "assets/touXiang.jpg",
          messages: [
            MessageEntity(
                time: DateTime.now(), content: "asfe", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "aefs", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "ss", isMeSend: true),
            MessageEntity(
                time: DateTime.now(), content: "eee", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "es", isMeSend: true),
          ])
    ];
  }

  init(List<ConversationEntity> conversations) {
    this.data = conversations;
  }

  pushMessage(MessageEntity msg, String master) {
    this.data.forEach((e) {
      if (e.objectId == master) {
        e.pushMsg(msg);
      }
    });
    notifyListeners();
  }

  /// 创建一个新的会话
  createConversation(MessageState msg, String target) {}
}
