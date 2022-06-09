import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remainder_application/presentation/resources/color_manager.dart';


class Themes{
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,//Appbar
    brightness: Brightness.light,

  //   textButtonTheme: TextButtonThemeData(
  //     style: TextButton.styleFrom(
  //       shape:RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //       animationDuration: const Duration(
  //         milliseconds: 500,
  //       ),
  //       elevation: 5,
  //       backgroundColor: ColorManager.primaryLight,
  //       // shadowColor: shadowColor ?? Colors.red,
  //       // primary: primary ?? Colors.deepPurple,
  //       // onSurface: onSurface ?? Colors.orange,
  //     ),
  //   ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        animationDuration: const Duration(
          milliseconds: 250,
        ),
        elevation: 5,
        backgroundColor: ColorManager.primaryLight,
        // shadowColor: shadowColor ?? Colors.red,
        // primary: primary ?? Colors.deepPurple,
        // onSurface: onSurface ?? Colors.orange,
      ),
    ),
  );

  static final dark = ThemeData(
    backgroundColor: Colors.grey[850],
    primaryColorDark: Colors.grey[800],//Appbar
    brightness: Brightness.dark,


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        animationDuration: const Duration(
          milliseconds: 250,
        ),
        elevation: 5,
        backgroundColor: ColorManager.primaryLight,
        // shadowColor: shadowColor ?? Colors.red,
        // primary: primary ?? Colors.deepPurple,
        // onSurface: onSurface ?? Colors.orange,
      ),
    ),
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      )
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.grey[400]:Colors.grey,
      )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Get.isDarkMode?Colors.grey[400]:Colors.grey,
      )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      )
  );
}


