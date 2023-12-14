import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nieproject/models/chat.dart';
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

  @override
  void initState() {
    super.initState();
    chatController
        .fetchMessagesFromApi()
        .then((value) => {}); // Fetch messages when the widget is initialized
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
              decoration: BoxDecoration(
                gradient: linearGradient,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => mainWindow);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          'NIE MCR',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth / 2.5),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.call),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.video_call),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth / 30),
                  Container(
                    width: double.infinity,
                    height: 1, // Adjust the line height as needed
                    color: Colors.white
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
                            final hasReply = chatItem.ticketReply != null;

                            double containerWidth = hasReply
                                ? chatItem.ticketReply
                                        .toString()
                                        .length
                                        .toDouble() *
                                    30
                                : chatItem.ticketContent
                                        .toString()
                                        .length
                                        .toDouble() *
                                    10;

                            return Column(
                              children: [
                                hasReply
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          // Reply section when a reply is present

                                          width: containerWidth,
                                          margin: EdgeInsets.only(
                                              bottom: screenHeight / 30),
                                          padding: EdgeInsets.only(
                                            bottom: screenHeight / 50,
                                            top: screenHeight / 50,
                                            left: screenWidth / 20,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: Colors.blue[400]
                                                ?.withOpacity(0.25),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        'assets/teacher.png'),
                                                    radius: screenHeight / 40,
                                                    backgroundColor:
                                                        Colors.transparent),
                                              ),
                                              SizedBox(width: screenWidth / 40),
                                              Flexible(
                                                child: Text(
                                                  chatItem.ticketContent
                                                      .toString(),
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      GoogleFonts.abhayaLibre(
                                                    color: Colors.white,
                                                    fontSize: screenWidth / 25,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: screenWidth / 40),
                                              SizedBox(width: screenWidth / 40),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          // Content without a reply
                                          width: chatItem.ticketContent
                                                  .toString()
                                                  .length
                                                  .toDouble() *
                                              50,
                                          margin: EdgeInsets.only(
                                              bottom: screenHeight / 30),
                                          padding: EdgeInsets.only(
                                            bottom: screenHeight / 50,
                                            top: screenHeight / 50,
                                            left: screenWidth / 20,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: Colors.blue[400]
                                                ?.withOpacity(0.1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  style:
                                                      GoogleFonts.abhayaLibre(
                                                    color: Colors.white,
                                                    fontSize: screenWidth / 25,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                  hasReply
                                                      ? chatItem.ticketReply
                                                          .toString()
                                                      : chatItem.ticketContent
                                                          .toString(),
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: screenWidth / 40),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: CircleAvatar(
                                                  radius: screenHeight / 40,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: AssetImage(
                                                      'assets/student.png'),
                                                ),
                                              ),
                                              SizedBox(width: screenWidth / 40),
                                            ],
                                          ),
                                        ),
                                      ),
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
                              color: Colors.white.withOpacity(0.5),
                            ),
                            fillColor: Colors.transparent,
                          ),
                          style: TextStyle(
                            color: Colors.white,
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
                        color: Colors.white,
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
