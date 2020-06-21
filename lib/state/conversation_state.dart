import 'package:flutter/cupertino.dart';
import 'package:flutter_tim/state/message_state.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

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
  List<Conversation> data = []; // 存放所有的会话

  ConversationState() {
    // 填充假数据
    this.data = [
      
    ];
  }

  init(List<Conversation> conversations) {
    this.data = conversations;
  }

  pushMessage(MessageEntity msg, String master) {
    
  }

}
