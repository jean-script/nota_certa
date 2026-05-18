import 'package:flutter/material.dart';
import 'package:ml_nota_certa/app/utils/hexcolor.dart';

class MyTheme {
  static Color containerIconEdit = Colors.blue;
  static Color containerIconRemove = Colors.red;
  static Color containerIconLink = Colors.blue.shade800;
  static Color iconColors = Colors.white;
  static Color menuHoveredColor = Colors.blue.shade700;
  static Color menuActiveColor = Colors.blueAccent;
  static Color menuActiveContainerColor = Colors.blue.withAlpha(35);
  static Color textButton = Colors.white;
  static Color activeItem = Colors.blue;
  static Color inativeItem = Colors.grey;
  static String fontFamily = "DM_Sans";

  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStatePropertyAll(
            BorderSide(color: Colors.grey.shade400),
          ),
          overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
          textStyle: const MaterialStatePropertyAll(
            TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black, size: 20),
      fontFamily: fontFamily,
      textTheme: TextTheme(
        labelSmall: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: fontFamily,
        ),
        labelMedium: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: fontFamily,
        ),
        labelLarge: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: fontFamily,
        ),
        titleSmall: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: fontFamily,
        ),
        titleMedium: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: fontFamily,
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: fontFamily,
        ),
      ),
      // primarySwatch: ,
      scaffoldBackgroundColor: HexColor('#e6e7e9'),
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      dividerTheme: DividerThemeData(color: Colors.grey.shade300),
      dividerColor: Colors.grey.shade300,
      // hoverColor: HexColor('#e6f8ff'),
    );
  }
}
