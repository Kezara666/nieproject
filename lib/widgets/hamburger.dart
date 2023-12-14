
  import 'package:flutter/material.dart';

void showPopupMenu(BuildContext context) async {
  final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
  final Offset offset = Offset(overlay.size.width - 50, 70); // Adjust the values based on your UI
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'settings',
          child: const Text('Settings'),
        ),
        PopupMenuItem<String>(
          value: 'changeLanguage',
          child: const Text('Change Language'),
        ),
        PopupMenuItem<String>(
          value: 'about',
          child: const Text('About'),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: const Text('Logout'),
        ),
      ],
    );

    // Handle the selected option
    if (result != null) {
      handleMenuOption(result);
    }
  }

  // Function to handle the selected menu option
  void handleMenuOption(String option) {
    switch (option) {
      case 'settings':
        // Handle settings
        break;
      case 'changeLanguage':
        // Handle change language
        break;
      case 'about':
        // Handle about
        break;
      case 'logout':
        // Handle logout
        break;
      // Add more cases for additional options if needed
    }
  }