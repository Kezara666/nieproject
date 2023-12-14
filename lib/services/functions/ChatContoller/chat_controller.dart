import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/models/chat.dart';
import 'package:nieproject/services/functions/ChatContoller/API/chat.dart';
import 'package:http/http.dart' as http;
import 'package:nieproject/services/functions/userDetails/user_details.dart';

class ChatController extends GetxController {
  RxList<Chat> items = <Chat>[].obs;
  final ApiService apiService = ApiService();
  UserDetails userDetails = Get.find();
  void addItem(Chat message) {
    items.add(message);
  }

  Future<void> fetchMessagesFromApi() async {
    try {
      final response = await http.get(
        Uri.parse(userChat+userDetails.loginUser),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Chat> chats = jsonData.map((json) => Chat.fromJson(json)).toList();

        // Clear the existing items list before adding new data
        items.clear();

        // Add the data from the API to the items list
        items.addAll(chats);
        print(items.length);
      } else {
        throw Exception("Failed to load chat data");
      }
    } catch (e) {
      print("Error fetching data from API: $e");
    }
  }

  Future<void> submitTicket(email,content,BuildContext context) async {
    
  const String apiUrl = sendChat;
  print("Failed to submit ticket: ${email} ${content}");
  final Map<String, dynamic> requestData = {
    "ticket_content": content.toString(),
    "user_email": email.toString()
  };

  try {
    final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode(requestData),
    
  );
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ticket submitted successfully.")),
      );
      fetchMessagesFromApi();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.statusCode.toString())),
      );}
      
  }
  catch (e) {
    print("Failed to submit ticket: ${e}");
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit ticket: ${e}")),
      );
  }
 
}
}
