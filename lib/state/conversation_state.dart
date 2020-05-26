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
                time: DateTime.now(), content: "用不用下载样式包？", isMeSend: false),
          ]),
      ConversationEntity(
          objectId: "1",
          objectName: "李四",
          objectPicture: "assets/touXiang.jpg",
          messages: [
            MessageEntity(
                time: DateTime.now(), content: "没有设定权限呗", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "加个盒子试试", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "好的👌", isMeSend: true),
          ]),
      ConversationEntity(
          objectId: "1",
          objectName: "王五",
          objectPicture: "assets/touXiang.jpg",
          messages: [
            MessageEntity(
                time: DateTime.now(), content: "有现成的插件吗", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "ffmmet", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "这是啥玩意", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "pub上有，你去看看", isMeSend: true),
            MessageEntity(
                time: DateTime.now(), content: "哦哦哦", isMeSend: false),
          ]),
      ConversationEntity(
          objectId: "1",
          objectName: "赵六",
          objectPicture: "assets/touXiang.jpg",
          messages: [
            MessageEntity(
                time: DateTime.now(), content: "好兄弟，打王者吗", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "四缺一", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "不来", isMeSend: true),
            MessageEntity(
                time: DateTime.now(), content: "还么吃饭", isMeSend: false),
            MessageEntity(
                time: DateTime.now(), content: "吃完叫我", isMeSend: true),
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
