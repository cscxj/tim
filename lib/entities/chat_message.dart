
/// {
///     "sender": "",
///     "time": "",
///     "content": "",
///     "picture": "",
///     "isMeSend":false
/// }
/// 
class ChatMessage {
  String sender;
  String time;
  String content;
  String picture;
  bool isMeSend;

  ChatMessage(
      {this.sender:'', this.time:'', this.content:'', this.picture:'assets/touXiang.jpg', this.isMeSend:false});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    time = json['time'];
    content = json['content'];
    picture = json['picture'];
    isMeSend = json['isMeSend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['time'] = this.time;
    data['content'] = this.content;
    data['picture'] = this.picture;
    data['isMeSend'] = this.isMeSend;
    return data;
  }
}