import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/models/user.dart';
import 'package:nieproject/pages/chat/chat.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/functions/userDetails/user_details.dart';


//send firebase admin devices token
  Future<void> addTokens() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String serverUrl = adminDeviceToken;

    if (token != null) {
      try {
        var response = await http.post(
          Uri.parse(serverUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'tokens': [token]
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          print(data['message']);
        } else {
          print('Failed to add tokens. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error adding tokens: $error');
      }
    } else {
      print('Failed to get FCM token.');
    }
  }


Future<void> login(
    String username, String password, BuildContext context) async {
  UserDetails userDetails = Get.find();
  ChatWindow chatWindow = Get.find();
  // Validate the form fields
  if (username.isEmpty || password.isEmpty) {
    // Show validation error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill in both username and password')),
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse(apiLogin),
      body: jsonEncode({'email': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      User user = User.fromJson(data['user']);

      // Decode the token

      //set the controller user
      userDetails.loginUser = username;
      userDetails.user = user;
      if (user.role == "user") {
        Get.to(() => chatWindow);
      }


      // Store the token securely (e.g., using shared_preferences)
      // You may want to create a service for this
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(user.firstName.toString())),
      );

      if (user.role == 'admin') {
        //add token device
        await addTokens();

        ///////////////////////////////
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('admin')),
        );

        Get.to(() => chatWindow);
      } else if (user.role == 'moderator') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('moderator')),
        );
      }
    } else if (response.statusCode == 400) {
      // Handle validation error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Please check your username and password and try again')),
      );
    } else {
      // Handle other server errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'An error occurred while logging in. Please try again later.')),
      );
    }
  } catch (error) {
    // Handle network or other errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $error')),
    );
  }

  
}
