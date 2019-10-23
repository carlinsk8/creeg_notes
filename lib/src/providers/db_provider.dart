import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'NotesDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async{

        await db.execute(
          'CREATE TABLE users ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'display_name TEXT,'
          'email TEXT,'
          'password TEXT,'
          'token TEXT'
          ')'
        );

      }
    );

  }

  newUser(String email, String password) async {
    final String token = genereToken();
    final db = await database;

    final res = db.insert('users', {'email':email,'password':password,'token':token,'display_name':''});
    
    return res;

  }

  Future<Map<String,dynamic>> getUserLogin(String email) async {

    final db = await database;

    final resp = await db.query('users', where: 'email= ?', whereArgs: [email]);
    
    return resp.isNotEmpty ? resp.first : null;

  }
  
  String genereToken(){
    var random = Random.secure();

    var values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }


}