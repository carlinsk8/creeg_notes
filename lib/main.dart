import 'package:flutter/material.dart';
import 'package:note_creeg/src/blocs/provider.dart';
import 'package:note_creeg/src/pages/home_pages.dart';
import 'package:note_creeg/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Creeg Notes',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
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
    );
  }
}