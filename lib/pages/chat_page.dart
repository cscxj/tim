import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tim/entities/chat_message.dart';
import 'package:flutter_tim/pages/chat_page/chat_app_bar.dart';
import 'package:flutter_tim/pages/chat_page/chat_message_view.dart';
import 'package:flutter_tim/state/message_state.dart';

class ChatPage extends StatefulWidget {
  final ConversationEntity conv;

  const ChatPage({Key key, this.conv}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _scrollController;
  TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _inputController.dispose();
  }

  double oldLayoutLength = .0; // 加载到新数据的新增布局长度

  void sendMessage(String msg) {
    setState(() {
      // TODO
    });
    _scrollController.animateTo(.0,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  // 构建上拉加载指示器
  Widget buildSimpleRefreshIndicator(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    oldLayoutLength = context.findRenderObject().paintBounds.width;
    const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
    return Opacity(
      opacity: opacityCurve
          .transform(min(pulledExtent / refreshIndicatorExtent, 1.0)),
      child: Column(
        children: <Widget>[
          Expanded(child: VerticalDivider()),
          Flexible(
              child: Container(
            padding: EdgeInsets.all(3.0),
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.2),
                      Colors.black.withOpacity(.1)
                    ])),
            child: const CupertinoActivityIndicator(),
          ))
        ],
      ),
    );
  }

  Future<void> _loadingData() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          // TODO
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (d){
        if (d.velocity.pixelsPerSecond.dx>0) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: ChatAppBar(),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: EasyRefresh.custom(
                scrollController: _scrollController,
                reverse: true,
                footer: CustomFooter(
                    enableInfiniteLoad: false,
                    extent: 40.0,
                    triggerDistance: 50.0,
                    footerBuilder: (context,
                        loadState,
                        pulledExtent,
                        loadTriggerPullDistance,
                        loadIndicatorExtent,
                        axisDirection,
                        float,
                        completeDuration,
                        enableInfiniteLoad,
                        success,
                        noMore) {
                      return Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: pulledExtent,
                              child: VerticalDivider(
                                endIndent: 16.0,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              height: 20.0,
                              //margin:EdgeInsets.only(bottom:13.0),
                              padding: EdgeInsets.all(3.0),
                              decoration: ShapeDecoration(
                                  shape: CircleBorder(),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(.2),
                                        Colors.black.withOpacity(.1)
                                      ])),
                              child: CupertinoActivityIndicator(
                                radius: 7.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                onLoad: _loadingData,
                slivers: <Widget>[
                  SliverLayoutBuilder(
                    builder: (_, constraints) {
                      return SliverToBoxAdapter(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: constraints.viewportMainAxisExtent),
                          child: Column(
                            children: widget.conv.messages.map((i) {
                              return ChatMessageView(
                                  message: i,
                                  picture: widget.conv.objectPicture);
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
            SafeArea(
                child: Container(
              child: Wrap(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                            autofocus: false,
                            controller: _inputController,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          )),
                          GestureDetector(
                            onTap: () {
                              sendMessage(_inputController.value.text);
                              _inputController.clear();
                            },
                            child: Container(
                              height: 60.0,
                              alignment: Alignment.center,
                              child: Text('发送',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          )
                        ],
                      )),
                  Divider(
                    height: .0,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/svg/tim_voice.svg',
                        width: 36,
                      ),
                      SvgPicture.asset(
                        'assets/svg/tim_picture.svg',
                        width: 36,
                      ),
                      SvgPicture.asset(
                        'assets/svg/tim_video.svg',
                        width: 36,
                      ),
                      SvgPicture.asset(
                        'assets/svg/tim_camera.svg',
                        width: 36,
                      ),
                      SvgPicture.asset(
                        'assets/svg/tim_folder.svg',
                        width: 36,
                      ),
                      SvgPicture.asset(
                        'assets/svg/tim_face.svg',
                        width: 36,
                      ),
                      SvgPicture.asset(
                        'assets/svg/tim_add2_small.svg',
                        width: 36,
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        )), 
    );
  }
}
