import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants{
   static Color? cor;
   static Color? corIcon, textCor, corAppBar, appBarIcon,corCard;
  static String font = "IndieFlower";

   

  static void  background(bool isDark){
   cor = isDark  ? Colors.grey[900] : Colors.white;
   corCard = isDark  ? Colors.grey[800] : Colors.white;
   corIcon = isDark ?  Colors.white :  Colors.grey[900];
   textCor = corIcon; 
   corAppBar = isDark ?  Colors.grey[900] :  Colors.blue;
  }



}