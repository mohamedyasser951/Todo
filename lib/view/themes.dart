import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluclr = Colors.lightBlue;
const Color yellowclr = Color(0xFFFFB746);
const Color pinkclr = Color(0xFFff4667);
const Color primaryclr = bluclr;

const Color darkgreyclr = Color(0xFF121212);
const Color darkheaderclr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColor: primaryclr);

  static final dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkgreyclr,
      backgroundColor: darkgreyclr);
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]));
}

TextStyle get heroStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14.0,
          color: Colors.white));
}
