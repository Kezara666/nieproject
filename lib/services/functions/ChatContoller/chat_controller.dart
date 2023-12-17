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
        Uri.parse(userChat + userDetails.user.id.toString()),
      );

      if (response.statusCode == 200) {
        try {
          Map<String, dynamic> jsonObject = json.decode(response.body);

          // Check if "student_messages" key exists and is a List
          if (jsonObject.containsKey("student_messages") &&
              jsonObject["student_messages"] is List) {
            // Extract the list under the key "student_messages"
            List<dynamic> chatJsonList = jsonObject["student_messages"];

            // Convert the list of JSON objects to a list of Chat objects
            List<Chat> chats =
                chatJsonList.map((json) => Chat.fromJson(json)).toList();

            // Do something with the 'chats' list, for example, print the number of items
            items.clear();

            // Add the data from the API to the items list
            items.addAll(chats);
            print(chats.length);
          } else {
            // Handle the case where the expected key is missing or the value is not a list
            throw Exception(
                "Invalid response format: Missing or invalid 'student_messages' key");
          }
        } catch (e) {
          // Handle exceptions that might occur during JSON decoding or processing
          print("Error: $e");
        }
      } else {
        // Handle other HTTP status codes
        throw Exception("Failed to load chat data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data from API: $e");
    }
  }

  Future<void> submitTicket(email, content, BuildContext context) async {
    String apiUrl = '$sendChat';
    print("Failed to submit ticket: ${email} ${content}");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'student_id': userDetails.user.id,
          'student_name': userDetails.user.firstName,
          'message': content,
          'message_status': 'sent' // Assuming studentName is the ID
        }),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ticket submitted successfully.")),
        );
        fetchMessagesFromApi();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.statusCode.toString())),
        );
      }
    } catch (e) {
      print("Failed to submit ticket: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit ticket: ${e}")),
      );
    }
  }
}
