import 'package:flutter/material.dart';


Column calenderWidowNavbar(double heigt, double width) {
  double iconSize = width / 15;
  const playAvatar= Color.fromRGBO(117, 152, 200, 1);
  return Column(
    children: [
      const LinearProgressIndicator(
          backgroundColor: playAvatar,
          value: 0.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent)),
      SizedBox(
        height: heigt / 50,
      ),
      Row(
        children: [
          // Adjust the fraction as needed

          Expanded(
            child: IconButton(
              icon: Icon(Icons.shuffle),
              onPressed: () {
                // Add your action here for the first button
              },
              color: Color.fromRGBO(117, 152, 200, 1), // Set the icon color to playAvatar
              iconSize: iconSize, // Set the icon size based on screen width
            ),
          ),

          Expanded(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Add your action here for the first button
              },
              color: playAvatar, // Set the icon color to playAvatar
              iconSize: iconSize, // Set the icon size based on screen width
            ),
          ),

          Expanded(
            child: IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                // Add your action here for the first button
              },
              color: playAvatar, // Set the icon color to playAvatar
              iconSize: iconSize, // Set the icon size based on screen width
            ),
          ),
          

          Expanded(
            child: IconButton(
              icon: Icon(Icons.repeat),
              onPressed: () {
                // Add your action here for the first button
              },
              color: playAvatar, // Set the icon color to playAvatar
              iconSize: iconSize, // Set the icon size based on screen width
            ),
          ),
          

          

          
          
        ],
      ),
      SizedBox(
        height: heigt / 35,
      ),
    ],
  );
}
