import 'dart:async';

import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nieproject/models/chat.dart';
import 'package:nieproject/pages/chat/call/call_page.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/functions/ChatContoller/chat_controller.dart';
import 'package:nieproject/utils/colors.dart';

class ChatWindow extends StatefulWidget {
  const ChatWindow({Key? key});

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  TextEditingController _textController = TextEditingController();
  final ChatController chatController = Get.find();
  OnAirScreen mainWindow = Get.find();
  // CallPage callWindow = Get.find();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    setState(() {
      chatController.fetchMessagesFromApi().then((value) => {});
    });
    _timer = Timer.periodic(Duration(microseconds: 50), (Timer timer) {
      chatController.fetchMessagesFromApi();
    });
    // Fetch messages when the widget is initialized
  }

  @override
  void dispose() {
    // Cancel the periodic timer in the dispose method
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        // await showDialog or Show add banners or whatever
        // return true if the route to be popped
        return false; // return false if you want to disable device back button click
      },
      child: WillPopScope(
        onWillPop: () async {
          // await showDialog or Show add banners or whatever
          // return true if the route to be popped
          return false; // return false if you want to disable device back button click
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => mainWindow);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Text(
                          'NIE MCR',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth / 2.5),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.call),
                        color: Colors.black,
                      ),
                      IconButton(
                        onPressed: () async {
                          chatController.callServer().then((_) {
                            print('Server function completed.');
                          });
                         
                        },
                        icon: Icon(Icons.video_call),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth / 30),
                  Container(
                    width: double.infinity,
                    height: 1, // Adjust the line height as needed
                    color: Colors.black
                        .withOpacity(0.5), // Adjust the line color as needed
                  ),
                  SizedBox(height: screenWidth / 30),
                  Obx(() {
                    return Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification:
                            (ScrollNotification scrollNotification) {
                          if (scrollNotification.metrics.pixels <= 0) {
                            chatController.fetchMessagesFromApi();
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: chatController.items.length,
                          itemBuilder: (context, index) {
                            final chatItem = chatController.items[index];
                            final hasReply = chatItem.reply != null;

                            double containerWidth = hasReply
                                ? chatItem.reply.toString().length.toDouble() *
                                    30
                                : chatItem.message
                                        .toString()
                                        .length
                                        .toDouble() *
                                    10;

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: BubbleNormal(
                                        text: chatItem.message.toString(),
                                        isSender: true,
                                        color:
                                            Color.fromARGB(255, 240, 241, 242),
                                        tail: true,
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width /
                                              15,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 40, 110, 215),
                                              const Color.fromARGB(
                                                  255, 59, 190, 255)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                chatItem.reply.toString() != 'null'
                                    ? Row(
                                        children: [
                                          CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15,
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.orange,
                                                    Color.fromARGB(
                                                        255, 204, 197, 11)
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                          BubbleNormal(
                                            text: chatItem.reply.toString(),
                                            isSender: false,
                                            color: Color.fromARGB(
                                                255, 240, 241, 242),
                                            tail: true,
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: screenWidth / 20),
                      Expanded(
                        child: TextFormField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            fillColor: Colors.transparent,
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle send button press
                          String message = _textController.text;
                          chatController.submitTicket(
                              chatController.userDetails.loginUser,
                              message,
                              context);
                          // Add the message to the chat list
                          _textController
                              .clear(); // Clear the input field // Clear the input field
                        },
                        icon: Icon(Icons.send),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth / 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
