import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renttas_flutter_app/chat_module/models/messages.dart';
import 'package:renttas_flutter_app/widgets/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LiveChat/comps/styles.dart';
import '../LiveChat/comps/widgets.dart';
import 'models/chats.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user;
  String userId = "";

  List<Chats> chatList = [];
  bool isLoad = false;

  @override
  void initState() {
    loadItem();
    super.initState();
  }

  void loadItem() async {
    chatList.clear();
    setState(() => isLoad = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? "";
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? phone = prefs.getString('phone');
    String? currency = prefs.getString('currency');
    String? roleId = prefs.getString('roleId');

    log(user.toString());
    log("userId====>$userId");
    log("name====>$name");
    log("email====>$email");
    log("phone====>$phone");
    log("currency====>$currency");
    log("roleId====>$roleId");
    await Future.delayed(const Duration(seconds: 2));
    chatList = Chats.fromJsonList(chats);
    setState(() => isLoad = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff54854C),
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Text(
          'Chat for Support',
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Admin Chat :-',
                  style: Styles.h1(),
                ),
                const Spacer(),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
          ),
          isLoad
              ? Flexible(
                  child: Container(
                    decoration: Styles.friendsBox(),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    decoration: Styles.friendsBox(),
                    child: ListView.builder(
                      itemCount: chatList.first.messages!.length,
                      // reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        var senderId = chatList.first.messages![i].senderId;
                        return ChatWidgets.messagesCard(
                          senderId == userId ? true : false,
                          chatList.first.messages![i].content,
                          "12:45AM",
                        );
                      },
                    ),
                  ),
                ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            color: Colors.white,
            child: ChatWidgets.messageField(
              onSubmit: (TextEditingController controller) async {
                if (controller.text.isEmpty) return GlobalWidgets.toast("Invaild message...");
                setState(() => isLoad = true);
                log(controller.text.toString());
                final msg = Messages(
                  id: math.Random().nextInt(100).toString(),
                  content: controller.text.toString(),
                  senderId: "5fca84cf-9302-4cd8-ae76-f7427ac3f072",
                  timestamp: "2023-01-01T10:25:00",
                );
                chatList.first.messages!.add(msg);
                await Future.delayed(const Duration(seconds: 1));
                setState(() => isLoad = false);
              },
            ),
          )
        ],
      ),
    );
  }
}
