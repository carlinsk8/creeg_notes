import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:note_creeg/src/preferences/user_preferences.dart';
import 'package:note_creeg/src/providers/db_provider.dart';

class UserProvider {

  final String _apiKey= 'AIzaSyDIXPaCmLVZaCT60HVpAAdn3UzHh5bYwWw';
  final prefes =  new UserPreferences();

  Future<Map<String, dynamic>> login(String email, String password) async{
    final _check = await _checkConetion();
    if(_check){
      final authData = {
        'email' : email,
        'password' : password,
        'returnSecureToken' : true
      };

      final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey',
        body: json.encode(authData)
      );

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      print(decodedResp);

      if( decodedResp.containsKey('idToken')){
        prefes.token = decodedResp['idToken'];
        return {'ok': true, 'token': decodedResp['idToken']};
      }else{
        final res = await DBProvider.db.getUserLogin(email);
        if( res!=null){
        
          final resp = await newUser( email,  password);
          return resp;
        }
        return {'ok': false, 'message': decodedResp['error']['message']};
      }
    }else{
      final res = await DBProvider.db.getUserLogin(email);
      print(res);
      if( res==null){
        
        return {'ok': false, 'message': 'Email no existe'};
      }else if(res['password']!=password){

        return {'ok': false, 'message': 'Password incorrecto'};
      }else{
        prefes.token = res['token'];
        return {'ok': true, 'token': res['token']};
      }
    }
    
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final _check = await _checkConetion();
    if(_check){
      final authData = {
        'email' : email,
        'password' : password,
        'returnSecureToken' : true
      };

      final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey',
        body: json.encode(authData)
      );

      Map<String, dynamic> decodedResp = json.decode(resp.body);

      print(decodedResp);

      if( decodedResp.containsKey('idToken')){
        prefes.token = decodedResp['idToken'];
        return {'ok': true, 'token': decodedResp['idToken']};
      }else{
        return {'ok': false, 'message': decodedResp['error']['message']};
      }
    }else{
      final res = await DBProvider.db.newUser(email,password);
      print(res);
      if( res==null){
        //prefes.token = decodedResp['idToken'];
        
        return {'ok': false, 'message': 'Email no existe'};
      }else{
        return {'ok': true};
      }
    }

  }

  Future<bool> _checkConetion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

}