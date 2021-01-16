import 'package:flutter/material.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
import 'package:lets_note/client-side/widgets/activity-page/login-page.dart';
import 'package:lets_note/server-side/server-main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'client-side/widgets/main-page/main-navigate.dart';

void main() {
  runServer();
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.then((value){
    int userId=value.getInt("userId");
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>LoginProvider(userId: userId??null,isLogin: userId!=null?true:false))
        ],
        child: VNote()));
  });

}

 class VNote extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(

       theme: ThemeData(
         floatingActionButtonTheme: FloatingActionButtonThemeData(
           foregroundColor: Colors.red,
         ),
       ),
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
         floatingActionButtonTheme: FloatingActionButtonThemeData(
           foregroundColor: Colors.white,
           backgroundColor: Colors.green
         ),

       ) ,
       themeMode: ThemeMode.dark,
       home: Provider.of<LoginProvider>(context).isLogin?MainNavigator():LoginPage(),
       debugShowCheckedModeBanner: false,
       );
   }
 }

