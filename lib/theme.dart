import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShitpostThemeColor {
  static const MaterialColor color = MaterialColor(
    _round6PrimaryValue,
    <int, Color>{
      50: Color(0xFFFCE4EC),
      100: Color(0xFFF8BBD0),
      200: Color(0xFFF48FB1),
      300: Color(0xFFF06292),
      400: Color(0xFFEC407A),
      500: Color(_round6PrimaryValue),
      600: Color(0xFFD81B60),
      700: Color(0xFFC2185B),
      800: Color(0xFFAD1457),
      900: Color(0xFF880E4F),
    },
  );
  static const int _round6PrimaryValue = 0XFFFF1D87; //el color de la app

  static const Color background = Color(0XFF121212); //el color de fondo

  static ButtonStyle outlineButtonStyle({ //el estilo de los botones
    Color color = Colors.white, //el color de los botones
    double padding = 24, //el tamaño de los botones
  }) {
    return OutlinedButton.styleFrom( //el estilo de los botones
      primary: color, //el color de los botones
      padding: EdgeInsets.symmetric(vertical: padding),
      side: BorderSide(color: color),
      shape: const RoundedRectangleBorder( //el borde de los botones
        borderRadius: BorderRadius.all(Radius.circular(100)), //el radius circular de los botones
      ),
    );
  }

  static ThemeData theme = ThemeData(   //el tema de la app
    brightness: Brightness.dark, //el brillo de la app
    scaffoldBackgroundColor: background, //el color de fondo de la app
    primarySwatch: color,
    primaryColor: color,
    textTheme: GoogleFonts.wendyOneTextTheme(   //el tipo de letra de la app
      ThemeData.dark().textTheme,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(  //el estilo de los botones
      style: outlineButtonStyle(),
    ),
    appBarTheme: ThemeData.dark().appBarTheme.copyWith( //el estilo de la barra de arriba
          elevation: 0, //la elevacion de la barra de arriba
          centerTitle: true, //el titulo de la barra de arriba
          backgroundColor: Colors.transparent, //el color de fondo de la barra de arriba
          titleTextStyle: GoogleFonts.wendyOne(fontSize: 25), //el tamaño de la letra de la barra de arriba
        ),
  );
}
