import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
=======
import 'package:note_creeg/src/preferences/user_preferences.dart';
import 'package:note_creeg/src/providers/provider.dart';
import 'package:note_creeg/src/pages/home_pages.dart';
import 'package:note_creeg/src/pages/login_page.dart';
import 'dart:io';
>>>>>>> 41c7dddfdde61973435dc7867e8b4d18174b7408

import 'package:note_creeg/onboarding.dart';
import 'util.dart';

void main() => runApp(App());

<<<<<<< HEAD
class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top bar color
      ),
    );
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: CustomColors.GreyBackground,
        fontFamily: 'rubik',
      ),
      home: Onboarding(),
=======
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    print(prefs.token);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Creeg Notes',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'signup' : (BuildContext context) => SignUpPage(),
          'home' : (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          //Se indica que el tema tiene un brillo luminoso/claro
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
        ),
        //Tema Oscuro, se usa cuando se activa el modo oscuro
        darkTheme: ThemeData(
          //Se indica que el tema tiene un brillo oscuro
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
        )
      )
>>>>>>> 41c7dddfdde61973435dc7867e8b4d18174b7408
    );
  }
}
