import 'package:flutter/material.dart';
import 'package:lets_note/server-side/main.dart';
import 'client-side/widgets/main-page/main-navigate.dart';

void main() {
  runServer();

  runApp(VNote());
}

 class VNote extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       theme: ThemeData.dark(),
       darkTheme: ThemeData(
         //  primaryColor: Colors.black54,
         // appBarTheme: AppBarTheme(
         //    brightness: Brightness.dark ),
         // inputDecorationTheme: InputDecorationTheme(
         //   hintStyle: TextStyle(color: Colors.white),
         //   labelStyle: TextStyle(color: Colors.white),
         // ),
         brightness: Brightness.dark, //text color
         canvasColor: Colors.white10, //background
         accentIconTheme: IconThemeData(color: Colors.white),
         bottomAppBarColor: Colors.white,

       ) ,
       themeMode: ThemeMode.dark,
       home: MainNavigator(),
       );
   }
 }

