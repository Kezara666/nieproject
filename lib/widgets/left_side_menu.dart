import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieproject/enviroment/api.dart';
import 'package:nieproject/enviroment/font.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/widgets/hamburger.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            width: screenWidth * 0.9,
            height: screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                scale: 0.2,
                fit: BoxFit.cover,
                image: AssetImage('assets/Comp 1_2.gif',
                
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight / 1.5,
                ),
                ListTile(
                  leading: Icon(Icons.settings), // Icon for settings
                  title: Text(translate("settings", language: language)),
                  onTap: () {
                    handleMenuOption('settings', context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info), // Icon for about
                  title: Text(translate("aboutUs", language: language)),
                  onTap: () {
                    handleMenuOption('about', context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout), // Icon for logout
                  title: const Text('Logout'),
                  onTap: () {
                    handleMenuOption('logout', context);
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.open_in_browser), // Icon for opening in web
                  title: const Text('Open in Web'),
                  onTap: () {
                    // Open the web page

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
