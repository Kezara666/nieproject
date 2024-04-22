import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nieproject/enviroment/font.dart';
import 'package:nieproject/pages/playListWithCalender/play-list-with-calender.dart';
import 'package:nieproject/pages/player/player.dart';
import 'package:nieproject/pages/twoCirclePlayListWindow/two_circle_list_window.dart';
import 'package:nieproject/widgets/hamburger.dart';

class MenuWindow extends StatefulWidget {
  @override
  State<MenuWindow> createState() => _MenuWindowState();
}

class _MenuWindowState extends State<MenuWindow> {
  OnAirScreen onAirScreen = Get.find();
  ProgramListCalenderWindow calender = Get.find();
  TwoCirclePlayList programChoice = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color.fromRGBO(3, 20, 48, 1)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Navigation bar
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => onAirScreen);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: screenWidth / 10,
                        height: screenHeight / 10,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showPopupMenu(context);
                    },
                    icon: const Icon(Icons.more_vert),
                    color: Colors.white,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => programChoice);
                  // Do something when 'Choose Program' is tapped
                  print('Choose Program tapped');
                },
                child: Container(
                  height: screenHeight / 3,
                  child: Image.asset('assets/Choose Program-01.png',fit: BoxFit.contain,),
                ),
              ),
              Text(
                translate('Choose by Program', language: language),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight/40
                ),
              ),

              InkWell(
                onTap: () {
                  Get.to(() => calender);
                  // Do something when 'Choose Date' is tapped
                  print('Choose Date tapped');
                },
                child: Container(height: screenHeight / 3,child: Image.asset('assets/Choose Date-01.png')),
              ),
              Padding(
                padding: language==3? EdgeInsets.only(left: screenWidth/5):EdgeInsets.only(left: 0),
                child: Text(
                  translate('Choose by Date', language: language),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight/40
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
