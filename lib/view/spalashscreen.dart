import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/home.dart';
import 'package:todo/view/themes.dart';

class Spalash extends StatelessWidget {
  const Spalash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 1000,
        splash: Icon(
          
          Icons.home,
          size: 70.0,
          color: Colors.white,
        ),
        nextScreen: Home(),
        splashTransition: SplashTransition.sizeTransition,
         
      
        curve: Curves.easeInOutExpo,
        
        backgroundColor: primaryclr);
  }
}
