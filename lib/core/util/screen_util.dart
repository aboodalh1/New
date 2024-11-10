import 'package:flutter/material.dart';

class ScreenSizeUtil{
  static late double screenHeight;
  static late double screenWidth;

  static void initSize(BuildContext context){
    screenHeight=MediaQuery.of(context).size.height;
    screenWidth=MediaQuery.of(context).size.width;
  }

}