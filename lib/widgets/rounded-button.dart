import 'package:flutter/material.dart';
import 'package:nieproject/utils/colors.dart';

class Buttons {
  static ClipOval buttonRound() {
    return ClipOval(
      child: Material(
        color: playAvatar, // Button color
        child: InkWell(
            splashColor: Color.fromARGB(255, 45, 189, 61), // Splash color
            onTap: () {},
            child: const SizedBox(
                width: 25,
                height: 25,
                child: Icon(
                  Icons.add, // Replace with your desired icon
                  size: 20, // Adjust the icon size as needed
                  color: Colors.black, // Icon color
                ))),
      ),
    );
  }

  
}
