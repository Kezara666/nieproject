import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/enviroment/font.dart';
import 'package:nieproject/pages/about.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/services/providers/language.dart';

void showPopupMenu(BuildContext context) async {
  final RenderBox overlay =
      Overlay.of(context)!.context.findRenderObject() as RenderBox;
  final Offset offset =
      Offset(overlay.size.width - 50, 70); // Adjust the values based on your UI
  final result = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
    items: [
      PopupMenuItem<String>(
        value: 'settings',
        child: Text(translate("settings", language: language)),
      ),
      PopupMenuItem<String>(
        value: 'changeLanguage',
        child: Text(translate("language", language: language)),
      ),
      PopupMenuItem<String>(
        value: 'about',
        child: Text(translate("aboutUs", language: language)),
      ),
      PopupMenuItem<String>(
        value: 'logout',
        child: const Text('Logout'),
      ),
    ],
  );

  // Handle the selected option
  if (result != null) {
    handleMenuOption(result, context);
  }
}

// Function to handle the selected menu option
void handleMenuOption(String option, BuildContext context) {
  OnAirScreen onAirScreen = Get.find();
  AboutPage aboutPage = Get.find();
  LanguageProvider languageProvider = Get.find();
  switch (option) {
    case 'settings':
      // Handle settings
      break;
    case 'changeLanguage':
      // Handle change language
      if (language < 3) {
        language++;
        //Get.to(() => onAirScreen);
      } else {
        language = 1;
        //Get.to(() => onAirScreen);
      }
      languageProvider.changeLanguage(language);
      break;
    case 'about':
      // Handle about
      Get.to(() => aboutPage);

      break;
    case 'logout':
      // Handle logout
      break;
    // Add more cases for additional options if needed
  }
}

String getLanguageIconPath() {
  LanguageProvider languageProvider = Get.find();
  
  switch (languageProvider.language) {
    case 1:
      return 'assets/english_icon.png';
    case 2:
      return 'assets/sinhala_icon.png';
    case 3:
      return 'assets/tamil_icon.png';
    default:
      return 'assets/english_icon.png';// Provide a default icon path
  }
}
