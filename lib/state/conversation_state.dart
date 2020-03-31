import 'package:flutter/cupertino.dart';
import 'package:flutter_tim/state/message_state.dart';
/// 会话
class ConversationEntity with ChangeNotifier{
  String objectId;
  String objectName;
  String objectPicture;
  List<MessageEntity> messages;

  ConversationEntity({this.objectId,this.messages, this.objectName, this.objectPicture});

  pushMsg(MessageEntity msg){
    this.messages.insert(0,msg);
  }
}

/// 会话管理类
class ConversationState with ChangeNotifier{
  List<ConversationEntity> data = []; // 存放所有的会话
  
  init(List<ConversationEntity> conversations){
    this.data = conversations;
  }

  pushMessage(MessageEntity msg,String master){
    this.data.forEach((e) {
      if (e.objectId == master) {
        e.pushMsg(msg);
      }
    });
    notifyListeners();
  }

  /// 创建一个新的会话
  createConversation(MessageState msg,String target){
    
  }
}