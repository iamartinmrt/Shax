import 'package:core/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ThemeConstants{
  static ThemeData darkAppTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorConstants.primaryColor,
    // primaryColor: Colors.purple,
    // primarySwatch: Colors.amber,
    // iconTheme: const IconThemeData(color: Colors.amber),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorConstants.black,
        onPrimary: ColorConstants.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      )
    ),
  );
  static ThemeData lightAppTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorConstants.primaryColor,
    // primarySwatch: Colors.blueGrey,
    // primaryColor: Colors.pink,
    // iconTheme: const IconThemeData(color: Colors.blueGrey),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: ColorConstants.white,
          onPrimary: ColorConstants.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        )
    ),
  );
}