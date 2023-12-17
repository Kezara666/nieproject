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

Future<void> login(String username, String password, BuildContext context) async {
  UserDetails userDetails = Get.find();
  ChatWindow chatWindow = Get.find();

  final FlutterSecureStorage _storage = FlutterSecureStorage();
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
      userDetails.loginUser=username;
      userDetails.user =user;
      if(user.role == "student"){
        Get.to(() => chatWindow);
      }

      // Store the token securely (e.g., using shared_preferences)
      // You may want to create a service for this
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(user.firstName.toString())),
      );

      if (user.role == 'admin') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('admin')),
        );
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
