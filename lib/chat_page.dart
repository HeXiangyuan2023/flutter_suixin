import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:suixin_app/api/beans/message_model.dart';
import 'package:suixin_app/api/biz_error.dart';
import 'package:suixin_app/api/http_apis.dart';
import 'package:suixin_app/app_colors.dart';
import 'package:suixin_app/logger.dart';
import 'package:suixin_app/widgets/loading.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String roleName;
  final String roleId;
  final String rolePic;
  const ChatPage(
      {super.key,
      required this.roleName,
      required this.roleId,
      required this.rolePic});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textInputController = TextEditingController();
  final _scrollController = ScrollController();
  List<MessageHistoryItem> _dataList = [];

  @override
  void initState() {
    super.initState();
    showLoading();
    HttpApis().getHistoryMessage(roleId: widget.roleId).then((value) {
      setState(() {
        _dataList = value ?? [];
      });
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        _scrollController.jumpTo(0);
      });
      dismissLoading();
    }).onError((error, stackTrace) {
      dismissLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roleName),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.light().backgroundTertiary,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: _dataList.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final item = _dataList[index];
                  return ChatBubble(
                    isMe: item.role == "user",
                    message: item.content ?? "",
                    time: timeFormatter(item.time ?? 0),
                    status: item.status ?? 1,
                    avatar: "https://i.pravatar.cc/150?img=1",
                  );
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _textInputController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: '输入你想说的话',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              if (_textInputController.text.isNotEmpty) {
                                _sendMessage(_textInputController.text);
                              }
                            },
                            icon: Transform.rotate(
                              angle: -0.6,
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            )),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String content) async {
    if (content.isEmpty) {
      return;
    }
    _textInputController.text = "";
    _dataList.insert(
        0,
        MessageHistoryItem(
            role: "user",
            content: content,
            status: 2,
            time: DateTime.now().millisecondsSinceEpoch));

    _dataList.insert(
        0,
        MessageHistoryItem(
            role: "assistant",
            content: "",
            status: 2,
            time: DateTime.now().millisecondsSinceEpoch));

    setState(() {
      _scrollController.jumpTo(0.0);
    });
    try {
      final resp = await HttpApis().sendMessage(content, roleId: widget.roleId);
      // 改变发送消息的状态 为已发送
      _dataList[1].status = 1;
      // 移除接受消息中的状态 重新添加一条返回值
      _dataList.removeAt(0);
      _dataList.insert(
          0,
          MessageHistoryItem(
              role: "assistant",
              content: resp?.answer ?? "",
              time: DateTime.now().millisecondsSinceEpoch));
    } catch (e) {
      _dataList.removeAt(0);
      _dataList.insert(
          0,
          MessageHistoryItem(
              role: "assistant",
              content: e is XTBizError ? e.message : e.toString(),
              time: DateTime.now().millisecondsSinceEpoch));
    }
    setState(() {
      _scrollController.jumpTo(0);
    });
  }
}

// class VoiceMessageContainer extends StatefulWidget {
//   const VoiceMessageContainer(
//       {super.key, required this.voiceUrl, required this.voiceContent});

//   final String voiceUrl;
//   final String voiceContent;

//   @override
//   State<VoiceMessageContainer> createState() => _VoiceMessageContainerState();
// }

// class _VoiceMessageContainerState extends State<VoiceMessageContainer> {
//   var _showText = false;

//   @override
//   Widget build(BuildContext context) {
//     const raduiSize = Radius.circular(16);
//     return Column(
//       children: [
//         Row(
//           textDirection: TextDirection.rtl,
//           children: [
//             Expanded(child: Container()),
//             InkWell(
//               child: Text(
//                 "转文字",
//                 style: AppTypography.h5(),
//               ),
//               onTap: () {
//                 setState(() {
//                   _showText = true;
//                 });
//               },
//             ),
//             const SizedBox(width: 6),
//             Container(
//               decoration: BoxDecoration(
//                   color: AppColors.light().white,
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.zero,
//                       topRight: raduiSize,
//                       bottomLeft: raduiSize,
//                       bottomRight: raduiSize)),
//               padding: const EdgeInsets.all(12),
//               child: Stack(
//                 children: [
//                   Positioned(
//                       child: Row(
//                     children: [
//                       Icon(Icons.voice_chat),
//                       SizedBox(
//                         width: 6,
//                       ),
//                       Text(
//                         "12S",
//                         style: AppTypography.h5(),
//                       )
//                     ],
//                   ))
//                 ],
//               ),
//             ),
//           ],
//         ),
//         _showText
//             ? Column(
//                 children: [
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   _contentText(),
//                 ],
//               )
//             : Container()
//       ],
//     );
//   }

//   Widget _contentText() {
//     const raduiSize = Radius.circular(4);
//     return Row(
//       textDirection: TextDirection.rtl,
//       children: [
//         Expanded(child: Container()),
//         Container(
//           decoration: BoxDecoration(
//               color: AppColors.light().white,
//               borderRadius: const BorderRadius.only(
//                   topLeft: raduiSize,
//                   topRight: raduiSize,
//                   bottomLeft: raduiSize,
//                   bottomRight: raduiSize)),
//           padding: const EdgeInsets.all(12),
//           child: Text(
//             widget.voiceContent,
//             style: AppTypography.h3(),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String time;
  final String avatar;
  final int status; // 1 完成 2 加载中

  const ChatBubble(
      {Key? key,
      required this.isMe,
      required this.message,
      required this.time,
      required this.avatar,
      this.status = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(avatar),
            )
          else
            const Spacer(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 41, 37, 37),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: !isMe ? Radius.zero : Radius.circular(20),
                      topRight: !isMe ? Radius.circular(20) : Radius.zero,
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: isMe ? Colors.blue : Colors.grey.shade200,
                  ),
                  child: status == 1 || isMe
                      ? Text(
                          message,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        )
                      : const SizedBox(
                          height: 10,
                          child: LoadingIndicator(
                              indicatorType: Indicator.lineScalePulseOutRapid)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(avatar),
            )
          else
            const Spacer(),
        ],
      ),
    );
  }
}

String timeFormatter(int time) {
  DateFormat outputFormat = DateFormat("MM-dd HH:mm:ss");
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(time);
  return outputFormat.format(dateTime);
}
