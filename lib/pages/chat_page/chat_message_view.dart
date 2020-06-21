import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tim/entities/chat_message.dart';
import 'package:flutter_tim/state/message_state.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

class ChatMessageView extends StatefulWidget {
  ChatMessageView(
      {Key key,
      this.isShowName: false,
      @required this.message,
      this.name: '',
      @required this.picture})
      : assert(message != null),
        super(key: key);

  final bool isShowName;
  final Message message;
  final String name;
  final String picture;

  @override
  _ChatMessageViewState createState() => _ChatMessageViewState();
}

class _ChatMessageViewState extends State<ChatMessageView> {
  Widget getPicture() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ClipOval(
        child: Image.asset(widget.picture, width: 40.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMeSent = widget.message.messageDirection == RCMessageDirection.Send;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMeSent // 是发送出去的来时接收的
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          isMeSent ? Container() : getPicture(),
          Column(
            crossAxisAlignment: isMeSent
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              widget.isShowName
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Text('${widget.name}:',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black.withOpacity(.7))),
                    )
                  : Container(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 260.0,
                ),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color:
                          isMeSent ? Colors.blue[200] : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(
                    widget.message.content.conversationDigest(),
                    style: TextStyle(fontSize: 16.0),
                  ), //暂时只支持文本，支持其他在这里改
                ),
              )
            ],
          ),
          isMeSent ? getPicture() : Container()
        ],
      ),
    );
  }
}
